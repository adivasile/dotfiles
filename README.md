## Personal config files

### Setup

1. [Install chezmoi](https://www.chezmoi.io/install/) 

2. Init chezmoi
```sh
chezmoi init git@github.com:adivasile/dotfiles.git
```
3. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

4. `cd` into setup folder and run ansible playbook
```sh
  cd setup/

  ansible-playbook playbook.yml -K
```
5. Apply chezmoi dotfiles

```sh
  chezmoi apply
```
