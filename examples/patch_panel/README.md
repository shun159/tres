# PatchPanel

openflow controller that emulates a software patch panel

## prerequisites

 - Erlang 20 or higher
 - Elixir 1.6.1 or higher
 - OpenFlow switch supports version 1.3

```iex
# To add a patch link
iex > :ok = PatchPanel.Openflow.Controller.create_patch("de780562fb45, 1, 2)
# To delete a patch link
iex > :ok = PatchPanel.Openflow.Controller.delete_patch("de780562fb45, 1, 2)
```
