import re

def read_tfvars(file_path):
    """Reads a .tfvars file and parses it into a dictionary."""
    variables = {}
    try:
        with open(file_path, 'r') as file:
            for line in file:
                # Skip empty lines and comments
                if line.strip() == '' or line.strip().startswith('#'):
                    continue
                # Split key and value using regex
                match = re.match(r'(\w+)\s*=\s*(.*)', line)
                if match:
                    key, value = match.groups()
                    value = value.strip()

                    # Determine the data type: boolean, list, integer, float, or string
                    if value.lower() in ("true", "false"):
                        value = value.lower() == "true"
                    elif value.startswith('[') and value.endswith(']'):
                        # Handle lists by stripping brackets and splitting by comma
                        value = [item.strip().strip('"') for item in value[1:-1].split(',')]
                    elif value.isdigit():
                        value = int(value)
                    elif re.match(r'^\d+\.\d+$', value):  # Handle floats
                        value = float(value)
                    elif value == '""':
                        value = ""
                    else:
                        value = value.strip('"')

                    variables[key] = value
    except FileNotFoundError:
        print(f"Error: The file '{file_path}' does not exist.")
    except Exception as e:
        print(f"An error occurred while reading the file: {e}")
    
    return variables

def write_tfvars(file_path, variables):
    """Writes a dictionary to a .tfvars file."""
    try:
        with open(file_path, 'w') as file:
            for key, value in variables.items():
                if isinstance(value, bool):
                    value_str = "true" if value else "false"
                elif isinstance(value, list):
                    value_str = f'["{", ".join(value)}"]'
                elif isinstance(value, int) or isinstance(value, float):
                    value_str = str(value)
                elif value == "":
                    value_str = '""'
                else:
                    value_str = f'"{value}"'
                file.write(f'{key} = {value_str}\n')
    except Exception as e:
        print(f"An error occurred while writing to the file: {e}")

def modify_tfvars():
    """Modifies the default values in a .tfvars file."""
    file_path = 'default.tfvars'  # Default file in the current directory
    variables = read_tfvars(file_path)

    if not variables:
        print("No variables found to modify or error reading the file.")
        return

    print("Current contents of the .tfvars file:")
    for key, value in variables.items():
        if isinstance(value, list):
            new_value = input(f'{key} (current value: {value}, enter comma-separated values to modify): ')
            if new_value:
                value = [item.strip() for item in new_value.split(',')]
        else:
            new_value = input(f'{key} (current value: "{value}"): ')
            if new_value:
                if isinstance(value, bool):
                    value = new_value.lower() in ("true", "1", "yes")
                elif isinstance(value, int):
                    try:
                        value = int(new_value)
                    except ValueError:
                        print("Invalid input. Keeping original value.")
                elif isinstance(value, float):
                    try:
                        value = float(new_value)
                    except ValueError:
                        print("Invalid input. Keeping original value.")
                else:
                    value = new_value
        variables[key] = value

    write_tfvars(file_path, variables)
    print("Successfully updated the default.tfvars file!")

if __name__ == "__main__":
    modify_tfvars()
