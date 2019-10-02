workflow "Deploy to GitHub Organization Pages" {
  resolves = ["hugo-deploy-gh-org-pages"]
  on = "push"
}

action "hugo-deploy-gh-org-pages" {
  uses = "StevenACoffman/hugo-deploy-gh-org-pages@v1.0.3"
  needs = ["Filters for GitHub Actions"]
  secrets = [
    "EMAIL",
    "DEPLOY_KEY_PRIVATE"
  ]
  env = {
    HUGO_VERSION = "0.56.3"
  }
}

action "Filters for GitHub Actions" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}
