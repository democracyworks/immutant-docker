# Immutant Deploys on Docker

## The Container

In theory, our deployed Immutant containers are pretty
straightforward. They are simply containers running Immutant, which
find Immutant projects that are mounted at `/servers/*`. Immutant is
run by [Supervisord][supervisor], and is discoverable by
[Synapse][synapse].

[supervisor]: http://supervisord.org/
[synapse]: https://github.com/airbnb/synapse

Given an Immutant container, you can run different projects by
attaching different Immuntant project volumes to it. The Immutant
container itself is only resposible for running Immutant and
Synapse. *What* Immutant is running is governed by what volumes are
available at runtime.

Additionally, the Immutant container holds various Synapse
configurations. You specify which you'd like to use by setting the
`IMMUTANT_ENVIRONMENT` environment variable. Currently, there are just
"production" and "development" configurations. This setting only
affects Synapse, not any project-level configurations.

## Deploying the Immutant Container

While we're on [Wercker][wercker], we are using a Wercker deploy step
of our own devising. It is important that all Immutant-based projects
use the same version of the step. You can see the current version
[here][wercker-step].

[wercker]: https://app.wercker.com/
[wercker-step]: https://app.wercker.com/#explore/steps/cmshea/immutant-deploy

> It's important to note that this deploy step will only deploy the
> Immutant container, *not* the project you are interested in. You'll
> need to pull and run those images on the docker hosts in a previous
> step. (Running those images should simply result in a stopped
> container with an Immutant archive and deployment descriptor, not a
> running application.)

The Wercker step requires a little bit of setup. The following
environment variables must be set on Wercker.

<table>
  <tr>
    <td><strong>PRIVATEKEY_PATH</strong></td>
    <td>Path to the private key that authenticates the deploy user on our docker hosts. This should be set in a previous Wercker step.</td>
  </tr>
  <tr>
    <td><strong>IMMUTANT_ENVIRONMENT</strong></td>
    <td>The environment name for the configurations to use. This would be set in your deploy pipeline.</td>
  </tr>
</table>

These must be set in *every* project that deploys the Immutant container.
