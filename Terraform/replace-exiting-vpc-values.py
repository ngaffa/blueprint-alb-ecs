import re

def update_terraform_file(file_path, replacements):
    """
    Update the Terraform file with the given replacements.
    
    :param file_path: The path to the Terraform file.
    :param replacements: A dictionary where keys are the current values to be replaced and values are the new values.
    """
    # Read the current content of the file
    with open(file_path, 'r') as file:
        content = file.read()
    
    # Apply replacements
    for old_value, new_value in replacements.items():
        content = re.sub(re.escape(old_value), new_value, content)
    
    # Write the updated content back to the file
    with open(file_path, 'w') as file:
        file.write(content)

if __name__ == "__main__":
    # Define the path to the Terraform file
    terraform_file_path = 'main.tf'
    
    # # Define the replacements to be made
    # replacements = {
    #     'var.vpc_cidr': 'new_vpc_cidr',
    #     'var.vpc_name': 'new_vpc_name',
    #     'var.existing_vpc_id': 'new_existing_vpc_id',
    #     'var.private_subnet_cidr_blocks': 'new_private_subnet_cidr_blocks',
    #     'var.public_subnet_cidr_blocks': 'new_public_subnet_cidr_blocks',
    #     'var.private_subnet_azs': 'new_private_subnet_azs',
    #     'var.public_subnet_azs': 'new_public_subnet_azs',
    #     'var.igw_name': 'new_igw_name',
    #     'var.public_route_cidr_block': 'new_public_route_cidr_block',
    #     'var.public_route_table_name': 'new_public_route_table_name',
    #     'var.private_route_table_name': 'new_private_route_table_name',
    #     'var.ami_id': 'new_ami_id',
    #     'var.instance_type': 'new_instance_type',
    #     'var.public_instance_name': 'new_public_instance_name',
    #     'var.private_instance_name': 'new_private_instance_name',
    #     'var.s3_bucket_name': 'new_s3_bucket_name'
    # }
    
    # Update the Terraform file
    update_terraform_file(terraform_file_path, replacements)
    print(f"Terraform file '{terraform_file_path}' has been updated.")
