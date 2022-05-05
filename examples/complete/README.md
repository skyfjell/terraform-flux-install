# Terraform Flux Install Module - Complete Example

For a quick deployment, install [`k3d`](https://k3d.io/) and create a cluster:

```
$ k3d cluster create tftest
```

Then from this directory run:

```
$ terraform init
$ terraform apply -auto-approve
```

When done, run:

```
$ terraform destroy -auto-approve
$ k3d cluster delete tftest
```

For usage, see the [main.tf](main.tf) file within
