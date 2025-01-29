infra:
	git pull
	terraform init
	terraform apply -auto-approve -var ssh_username=centos -var ssh_password=Adminadmin123$

ansible:
	git pull
	ansible-playbook -i $(tool_name)-internal.cloudaws.shop, toolsautomation.yaml -e ansible_username=centos -e ansible_password=Adminadmin123$ -e tool_name=$(tool_name)