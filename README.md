# Helm Charts

This repo uses [chart-releaser Action](https://github.com/helm/chart-releaser-action) to host helm charts

## Setup

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