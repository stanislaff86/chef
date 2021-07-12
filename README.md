# Errbit installation with Chef (test task)

To complete the test task, I configured 3 servers: chef-server, chef-workstation and a node. (used information from https://linuxconfig.org/how-to-install-chef-server-workstation-and-chef-client-on-ubuntu-18-04). All servers run on Ubuntu 18.04.5 LTS.

### chef-workstation
To install Errbit on the node I downloaded next cookbooks from the Chef supermarket:
 - ruby_rbenv (https://supermarket.chef.io/cookbooks/ruby_rbenv)
 - sc-mongodb (https://supermarket.chef.io/cookbooks/sc-mongodb)

and created cookbook for errbit by running ```chef generate cookbook errbit``` and edited ```recipes/default.rb``` file

For ruby I choosed 2.7.4 version, for mongodb - 4.4.6 (edited the attribute files)

Then I uploaded cookbooks to chef-server

```
knife cookbook upload ruby-rbenv
knife cookbook upload sc-mongodb
knife cookbook upload errbit
```

and added these cookbooks to the run-list of a node

```knife node edit client-node-1```

```{
  "name": "client-node-1",
  "chef_environment": "_default",
  "normal": {
    "tags": [

    ]
  },
  "policy_name": null,
  "policy_group": null,
  "run_list": [
    "recipe[ruby_rbenv]",
    "recipe[sc-mongodb]",
    "recipe[errbit]"
]

}```

After these steps I run the Chef client on the node

```chef-client```

## TODO
 - add attributes to errbit cookbook
 - refactor recipes
 ... and many more :-)
