# Swap

Master: [![Build Status](https://api.travis-ci.org/sansible/swap.svg?branch=master)](https://travis-ci.org/sansible/swap)  
Develop: [![Build Status](https://api.travis-ci.org/sansible/swap.svg?branch=develop)](https://travis-ci.org/sansible/swap)

This roles configures SWAP memory.




## ansible.cfg

This role is designed to work with merge "hash_behaviour". Make sure your
ansible.cfg contains these settings

```INI
[defaults]
hash_behaviour = merge
```




## Installation and Dependencies

This role has no dependencies




## Tags

This role uses two tags: **build** and **configure**

* `build` - Creates swap file and configures system to use it.
* `configure` - does nothing, kept for compatibility with 1.9 (missing tags
  causes errors)




## Examples

To simply add swap to your server:

```YAML
- name: Add swap memory to the server
  hosts: sandbox

  pre_tasks:
    - name: Update apt
      become: yes
      command: apt-get update
      tags:
        - build

  roles:
    - role: sansible.swap
```
