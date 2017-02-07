# Flow

## Gathering before server state by Ansible

- Distribute original facts
- Gather facts and store it to before/{hostname} directory

		ansible centos7_ssh -i hosts -m setup | sed '1c\{' > spec/localhost/before/centos7_ssh.json

## Gathering after server state by Ansible

- Gather facts and store it to after/{hostname} directory
- Delete original facts

## Compare before facts and after facts by Serverspec

- Compare both facts using Serverspec local mode.  
  Regarde before facts as correct state and after facts as test state.

