<div align="center">
    <img src="images/fusion-icon.jpg">
</div>

# fusion

A cross-platform standalone package/app manager with the highest possible simplicity.

# Idea

- To create a package manager that has no dependency management
    - Thus, we will have standalone independent packages/apps
- To create a package ecosystem
    - Where anyone can publish their package/app
    - Support a publisher profile system
    - Where a specific version of the software can be installed
    - Where the publisher can enable or disable a specific version of their software
- To support all the desktop platforms (Windows, MacOS, Linux)

### Profile System Overview

- Users should have a repo called **fusion-account**
- It will have a **fusion.account** file that will contain:
    - User display name [string]
    - User bio [string]
    - User Account Active [bool]
      <br> (use this to efficiently turn off your fusion account along with all your packages)
    - packages [list of enabled packages along with their specific version]

#### Example Structure for a fusion account

```shell
(gitHub/gitlab account)
└── fusion-account                  # your fusion storage
    ├── fusion.account              # your fusion profile info
    └── packages                    # this directory contains refs of your apps/packages
        ├── awesome-app             # your app/package name
        │   └── fusion.info   # contains package info (will be explained shortly)
        └── dev-utility             # another app/package name
            └── fusion.info                                                             
```

#### Example Content of `fusion.account`

```json
{
  "display-name": "your-fusion-account-username",
  "bio": "A package publisher company or individual",
  "active": true,
  "packages": {
    "awesome-app": {
      "status": "enabled"
    },
    "dev-utility": {
      "status": "disabled"
    }
  }
}
```

> Note that your **(gitlab/gitHub) username** will be considered as your unique identifier.

### Writing `fusion.info` file

#### Structural definition of `fusion.info`

In the above example for `fusion-account` structure, we have seen two packages namely, `awesome-app` & `dev-utility`.

Each of them is having a `fusion.info` file.
This file provides the package manager with the following data:

- The package's name (if more than one user has the same package name, then, fusion shows options while installing the
  package accordingly, ordered by update date)
- Its author and maintainer info
- different package versions and their status (either enabled or disabled)
- different types of channels available for each version (beta, alpha, stable, nightly)
    - Beta versions: Pre-release versions of software with major features complete, but still undergoing testing and
      refinement.
    - Alpha versions: Early pre-release versions of software, often with limited functionality and used for internal
      testing and development.
    - Stable versions: Fully tested and reliable versions of software intended for public use.
    - Nightly versions: Highly experimental and automated builds of the latest code, generated and released every night
      for developers and enthusiasts to test and provide feedback.
- metadata used by `fusion` to download and install the package for the three desktop platforms
- pre-download & post-download scripts that are to be executed

#### Example Content of `fusion.info`

```json
{
  "name": "",
  "description": "",
  "license": "",
  "opensource": true,
  "source-repo": "",
  "host-type": "This field tells fusion that whether the host of this package is its \"author\" or \"maintainer\"",
  "platforms": [
    {
      "platform": "windows/macos/linux or any specific linux distribution, just make sure the name you provide must match the one given at /etc/os-release of your target linux distribution",
      "platform-version": "target-platform-version",
      "platform-arch": "x64/x86/amd64",
      "channels": {
        "channel-type": "beta/alpha/stable/nightly",
        "versions": [
          {
            "version": "1.0",
            "status": "enabled",
            "setup": [
              "<links to program binaries or config files or a zip setup/>"
            ],
            "pre-download-script": "<link/>",
            "post-download-script": "<link/>"
          }
        ]
      }
    }
  ]
}
```

#### How to write `target-platform-version`?

```groovy
for
linux // 22.04, 36, etc, which is the linux distro version.
for
macos // Version 14.5
for
windows // Windows 10
```

Note that, `target-platform-version` can be left null if there is no targeted platform version.

But if the platform version isn't null and it does not match, `fusion` will still continue to install the package by
showing a warning that says

```text
this program is not targeted for your platform version, 
and may fail to run.
Do you still want to install it (Y/N) ?
```

### Storage System Overview

- To store packages at the **fusion-account** repo of the user under the directory name `packages`
- To store registrations of users as **gitHub/gitlab account link** on the **fusion-users** repo

