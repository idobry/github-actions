# K8S Resources Valitation GitHub action

Dependencies:
* Create GitHub secret which will contain the Slack's webhook url
* Charts must be under `/charts` folder

workflow example:

```yaml
on: push
name: workloadslint

jobs:
  changedFiles:
    name: workloads linter
    runs-on: ubuntu-latest
    steps:
    - uses: idobry/github-actions@master
    - name: verify deployments
      env:
        SLACK_URL: ${{ secrets.SLACK_URL }}
      uses: ./.github/actions/k8s_resources_validation
```
