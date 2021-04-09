# Helm charts

## Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```console
helm repo add vikaspogu https://vikaspogu.dev/helm-charts/
```

You can then run `helm search repo vikaspogu` to see the charts.

## GitHub Actions

## Chart Release Action

This repo uses [chart-releaser Action](https://github.com/helm/chart-releaser-action) to host helm charts on master branch

### Setup

- A GitHub repo containing a directory with your Helm charts (eg: /charts)
- A GitHub branch called gh-pages to store the published charts
    ```bash
    git checkout --orphan gh-pages
    git rm -rf .
    git commit -m "Initial commit" --allow-empty
    git push
    ```
- Create a workflow .yml file in your .github/workflows directory
- Create a secret in your repository, `CR_TOKEN`, which contains a GitHub personal access token with `repo` scope

### Example Workflow

Create a workflow (eg: .github/workflows/release.yml):

```yaml
name: Release Charts
on:
  push:
    branches:
      - master
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
        with:
          fetch-depth: 0
      - name: Configure Git
        run: |
          git config user.name "$GITHUB_ACTOR"
          git config user.email "$GITHUB_ACTOR@users.noreply.github.com"
      - name: Install Helm
        uses: azure/setup-helm@v1
        with:
          version: v3.4.0
      - name: Run chart-releaser
        uses: helm/chart-releaser-action@v1.1.0
        env:
          CR_TOKEN: "${{ secrets.CR_TOKEN }}"
```

## Linting and Testing Charts

This repo uses [Ct](https://github.com/helm/chart-testing) (or Chart Testing) tool for [linting and testing Helm charts](https://redhat-cop.github.io/ci/linting-testing-helm-charts.html)

## Chart Testing Action

This repo uses [chart-testing Action](https://github.com/helm/chart-testing-action) to host helm charts on PR's,Feature,Bugfix branches

### Example Workflow

Create a workflow (eg: .github/workflows/lint-test.yml):

```yaml
name: Lint and Test Charts
on: pull_request
jobs:
  lint-test:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
        with:
          fetch-depth: 
      - name: Set up Helm
        uses: azure/setup-helm@v1
        with:
          version: v3.4.0
      - uses: actions/setup-python@v2
        with:
          python-version: 3.7
      - name: Set up chart-testing
        uses: helm/chart-testing-action@v2.0.1
      - name: Run chart-testing (list-changed)
        id: list-changed
        run: |
          changed=$(ct list-changed)
          if [[ -n "$changed" ]]; then
            echo "::set-output name=changed::true"
          fi
      - name: Run chart-testing (lint)
        run: ct lint
      - name: Create kind cluster
        uses: helm/kind-action@v1.0.0
        if: steps.list-changed.outputs.changed == 'true'
      - name: Run chart-testing (install)
        run: ct install
```
