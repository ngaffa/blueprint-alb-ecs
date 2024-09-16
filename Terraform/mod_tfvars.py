import sys 
import os
import re
import json

def find_replace(file_path, replacements):
    with open(file_path, 'r') as file:
        content = file.read()
    
    for key, value in replacements.items():
        if isinstance(value, (list, dict)):
            # Use json.dumps for lists and dictionaries, ensure_ascii=False to preserve non-ASCII characters
            replacement_value = json.dumps(value, ensure_ascii=False)
        else:
            # Use str(value) for other types
            replacement_value = str(value)
        
        content = content.replace(f"<{key}>", replacement_value)
    
    with open(file_path, 'w') as file:
        file.write(content)

def is_valid_vpc_cidr(cidr):
    # Validates both standard CIDR blocks and allows 0.0.0.0/0
    pattern = r'^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])/(1[6-9]|2[0-8])$|^0\.0\.0\.0/0$'
    return bool(re.match(pattern, cidr))

def is_valid_subnet_cidr(cidr):
    pattern = r'^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])/(1[6-9]|2[0-9]|3[0-2])$'
    return bool(re.match(pattern, cidr))

def is_valid_az(az):
    pattern = r'^[a-z]{2}-[a-z]+-\d[a-z]$'
    return bool(re.match(pattern, az))

def is_valid_subnet_id(subnet_id):
    pattern = r'^subnet-[a-f0-9]{17}$'  
    return bool(re.match(pattern, subnet_id))

def get_input(prompt, validation_func=None):
    while True:
        value = input(prompt)
        if validation_func is None or validation_func(value):
            return value
        print("Invalid input. Please try again.")

def get_list_input(prompt, validation_func=None):
    while True:
        value = input(prompt)
        try:
            lst = json.loads(value)
            if not isinstance(lst, list):
                raise ValueError("Input must be a JSON list")
            
            if validation_func is not None:
                invalid_items = [item for item in lst if not validation_func(item)]
                if invalid_items:
                    raise ValueError(f"Invalid items found: {', '.join(invalid_items)}")
            
            return lst
        except json.JSONDecodeError:
            print("Invalid JSON format. Please enter a valid JSON list.")
        except ValueError as e:
            print(f"Invalid input: {str(e)}")

def main():
    tfvars_file = "default.tfvars"
    replacements = {}

    # Basic inputs
    replacements["REGION"] = get_input("Enter the AWS region: ")
    replacements["PROFILE"] = get_input("Enter the AWS profile: ")
    replacements["ENVIRONMENT"] = get_input("Enter the environment: ")
    replacements["PROJECT"] = get_input("Enter the project name: ")
    replacements["DEVELOPER"] = get_input("Enter the developer name: ")
    replacements["ARCHITECT"] = get_input("Enter the architect name: ")
    replacements["COMPANY"] = get_input("Enter the company name: ")

    # VPC Creation
    create_vpc = get_input("Do you want to create a VPC? (true/false): ").lower() == 'true'
    replacements["CREATE_VPC"] = str(create_vpc).lower()

    if create_vpc:
        replacements["VPC_CIDR"] = get_input("Enter the VPC CIDR: ", is_valid_vpc_cidr)
        replacements["PRIVATE_SUBNET_CIDR_BLOCKS"] = get_list_input("Enter the private subnet CIDR blocks (as a JSON list): ", is_valid_subnet_cidr)
        replacements["PRIVATE_SUBNET_AZS"] = get_list_input("Enter the private subnet AZs (as a JSON list): ", is_valid_az)
        replacements["PUBLIC_SUBNET_CIDR_BLOCKS"] = get_list_input("Enter the public subnet CIDR blocks (as a JSON list): ", is_valid_subnet_cidr)
        replacements["PUBLIC_SUBNET_AZS"] = get_list_input("Enter the public subnet AZs (as a JSON list): ", is_valid_az)
    else:
        replacements["EXISTING_VPC_ID"] = get_input("Enter the existing VPC ID: ")
        replacements["EXISTING_PRIVATE_SUBNET_IDS"] = get_list_input("Enter the existing private subnet IDs (as a JSON list): ", is_valid_subnet_id)
        replacements["EXISTING_PUBLIC_SUBNET_IDS"] = get_list_input("Enter the existing public subnet IDs (as a JSON list): ", is_valid_subnet_id)

    # Resource-specific settings
    replacements["VPC_NAME"] = get_input("Enter the VPC name: ")
    replacements["PRIVATE_SUBNET_NAME_FORMAT"] = get_input("Enter the private subnet name format: ")
    replacements["PUBLIC_SUBNET_NAME_FORMAT"] = get_input("Enter the public subnet name format: ")
    replacements["IGW_NAME"] = get_input("Enter the Internet Gateway name: ")
    replacements["PUBLIC_ROUTE_CIDR_BLOCK"] = get_input("Enter the public route CIDR block: ", is_valid_vpc_cidr)
    replacements["PUBLIC_ROUTE_TABLE_NAME"] = get_input("Enter the public route table name: ")
    replacements["PRIVATE_ROUTE_TABLE_NAME"] = get_input("Enter the private route table name: ")
    replacements["AMI_ID"] = get_input("Enter the AMI ID: ")
    replacements["INSTANCE_TYPE"] = get_input("Enter the instance type: ")
    replacements["PUBLIC_INSTANCE_NAME"] = get_input("Enter the public instance name: ")
    replacements["PRIVATE_INSTANCE_NAME"] = get_input("Enter the private instance name: ")
    replacements["S3_BUCKET_NAME"] = get_input("Enter the S3 bucket name: ")

    # Replace values in the .tfvars file
    find_replace(tfvars_file, replacements)
    print(f"Successfully updated {tfvars_file}")

if __name__ == "__main__":
    main()