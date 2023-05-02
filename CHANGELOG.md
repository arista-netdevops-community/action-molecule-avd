# Changelog for action-molecule-avd

## v1.6

- Fix: Catch git error and consider /github/workspace as safe by @gmuloc in https://github.com/arista-netdevops-community/action-molecule-avd/pull/15

## v1.5

- Bump: Update docker by @carlbuchmann in https://github.com/arista-netdevops-community/action-molecule-avd/pull/13

## v1.4

### Bug fixes

- Fix: Fail on all error codes by @carlbuchmann in https://github.com/arista-netdevops-community/action-molecule-avd/pull/12

## v1.3

### Features

 - Update to python3.8 and add galaxy_file argument ([#7](https://github.com/arista-netdevops-community/action-molecule-avd/issues/7))

### Bug fixes

 -  Restore proper spacing in action.yml ([#9](https://github.com/arista-netdevops-community/action-molecule-avd/issues/9))
 - Update entrypoint shell to support regex match ([#6](https://github.com/arista-netdevops-community/action-molecule-avd/issues/6))

### Documentation

 - Update README with galaxy_file knob ([#10](https://github.com/arista-netdevops-community/action-molecule-avd/issues/10))

### Other changes

- Build system: Add changelog builder
- Build system: Build docker image with GH actions
- Build system: Update build context
- Build system: Update docker tag builder
- Build system: Add PR linter for conventional commits ([#8](https://github.com/arista-netdevops-community/action-molecule-avd/issues/8))

## v1.2

### Bug fixes

- Update entrypoint shell to support regex match ([#6](https://github.com/arista-netdevops-community/action-molecule-avd/issues/6))

## v1.1

- Add option to select version of Ansible outside of requirements
- Add test to validate Ansible is installed

## v1.0

- Initial Release
