<div align="center">
<img src="https://github.com/openlit/.github/blob/main/profile/assets/wide-logo-no-bg.png?raw=true" alt="OpenLIT Logo" width="30%"><h1>
OpenTelemetry-native LLM Application Observability</h1>

**[Documentation](https://docs.openlit.io/) | [Quickstart](#-getting-started) | [Python SDK](https://github.com/openlit/openlit/tree/main/sdk/python)**

[![OpenLIT](https://img.shields.io/badge/OpenLIT-orange)](https://github.com/openlit/openlit)
[![License](https://img.shields.io/github/license/openlit/helm?label=License&logo=github&color=f80&logoColor=white)](https://github.com/openlit/helm/blob/main/LICENSE)
[![Downloads](https://static.pepy.tech/badge/openlit/month)](https://pepy.tech/project/openlit)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/openlit/helm)](https://github.com/openlit/helm/pulse)
[![GitHub Contributors](https://img.shields.io/github/contributors/openlit/helm)](https://github.com/openlit/helm/graphs/contributors)
[![Chart Version](https://img.shields.io/github/tag/openlit/helm.svg?&label=Chart%20Version&logo=helm)](https://github.com/openlit/helm/tags)
[![Helm Test](https://github.com/openlit/helm/actions/workflows/helm-test.yml/badge.svg?branch=main)](https://github.com/openlit/helm/actions/workflows/helm-test.yml)

[![Slack](https://img.shields.io/badge/Slack-4A154B?logo=slack&logoColor=white)](https://join.slack.com/t/openlit/shared_invite/zt-2etnfttwg-TjP_7BZXfYg84oAukY8QRQ)
[![X](https://img.shields.io/badge/follow-%40OpenLIT-1DA1F2?logo=x&style=social)](https://twitter.com/openlit_io)

</div>

![OpenLIT Banner](https://github.com/openlit/.github/blob/main/profile/assets/github-readme-repo-banner.png?raw=true)

## Introduction

OpenLIT is an **OpenTelemetry-native** GenAI and LLM Application Observability tool. It's designed to make the integration process of observability into GenAI projects as easy as pie – literally, with just **a single line of code**. Whether you're working with popular LLM Libraries such as OpenAI and HuggingFace or leveraging vector databases like ChromaDB, OpenLIT ensures your applications are monitored seamlessly, providing critical insights to improve performance and reliability.

This project proudly follows the [Semantic Conventions](https://github.com/open-telemetry/semantic-conventions/tree/main/docs/gen-ai) of the OpenTelemetry community, consistently updating to align with the latest standards in observability.

## 💿 Installation

To install the OpenLIT chart with the release name `openlit`:

```bash
helm repo add openlit https://openlit.github.io/helm/

helm repo update

helm install openlit openlit/openlit
```

> 🔧 **Note:** If the `openlit` StatefulSet Pod appears in an error state after installing the OpenLIT Helm chart, it may be due to the ClickHouse setup. Allow time for ClickHouse to fully initialize, which should help the `openlit` pod become healthy. If issues persist, restarting the `openlit` pod will resolve the issue.


## 🚀 Getting Started post Installation

After the OpenLIT chart is successfully deployed to your Kubernetes cluster, you'll need to generate an API key that can be used by the OpenLITmetry SDKs to authenticate requests to the OpenLIT platform.

### ⚡️ Instrument your Application with OpenLIT

Select the SDK that matches your application's programming language and integrate LLM monitoring with just a **single line of code**.

Install the `openlit` [Python SDK](https://pypi.org/project/openlit/) using pip:

```shell
pip install openlit
```

Add the following two lines to your application code:

```python
import openlit

openlit.init()
```

##### Example Usage for monitoring `OpenAI` Usage:

```python
from openai import OpenAI
import openlit

openlit.init()

client = OpenAI(
    api_key="YOUR_OPENAI_KEY"
)

chat_completion = client.chat.completions.create(
    messages=[
        {
            "role": "user",
            "content": "What is LLM Observability",
        }
    ],
    model="gpt-3.5-turbo",
)
```

Refer to the `openlit` [Python SDK repository](https://github.com/openlit/openlit/tree/main/sdk/python) for more advanced configurations and use cases.

### Visualize and Analyze

Once you have `OpenLIT` SDKs set up, you can instantly get insights into how your LLM applications. Just head over to OpenLIT UI at `127.0.0.1:3000` on your browser to start exploring.

With OpenLIT, you get a simple, powerful view into important info like how much you’re spending on LLMs, which parts of your app are using them the most, and how well they’re performing. Find out which LLM models are favorites among your applications, and dive deep into performance details to make smart decisions. This setup is perfect for optimizing your app performance and keeping an eye on costs.

## Configuration

The following table lists the configurable parameters of the OpenLIT chart and their default values.

| Variable Name                          | Description                                                                                         | Default Value                        |
|----------------------------------------|-----------------------------------------------------------------------------------------------------|--------------------------------------|
| `nameOverride`                         | Overrides the default name for the release.                                                        | `""`                                 |
| `fullnameOverride`                     | Overrides the default fullname for the release.                                                    | `""`                                 |
| `replicaCount`                 | Number of replicas                                                                                  | `1`                                  |
| `image.repository`             | Image repository                                                                                    | `"ghcr.io/patcher9/openlit"`         |
| `image.pullPolicy`             | Image pull policy                                                                                   | `"IfNotPresent"`                     |
| `image.tag`                    | Image tag (overrides the chart appVersion)                                                         | `"0.0.6"`                            |
| `imagePullSecrets`             | List of secrets containing credentials to pull images                                              | `[]`                                 |
| `service.type`                 | Type of service                                                                                     | `LoadBalancer`                       |
| `service.port`                 | Port on which the service is exposed                                                                | `3000`                               |
| `service.sessionAffinity`      | Session affinity configuration                                                                      | `None`                               |
| `resources.limits.cpu`         | CPU limit                                                                                           | `1000m`                              |
| `resources.limits.memory`      | Memory limit                                                                                        | `1280Mi`                             |
| `resources.requests.cpu`       | CPU request                                                                                         | `100m`                               |
| `resources.requests.memory`    | Memory request                                                                                      | `128Mi`                              |
| `config.sqlite_url`            | SQLite database URL                                                                                 | `file:/app/client/data/data.db`     |
| `config.database.name`         | OpenLIT Backend Database name                                                                       | `openlit`                            |
| `config.database.username`     | Database username (skip if `secrets.existingSecret` is true)                                        | `default`                            |
| `config.database.password`     | Database password (skip if `secrets.existingSecret` is true)                                        | `OPENLIT`                            |
| `config.database.host`         | Database host                                                                                       | `"openlit-db.default.svc.cluster.local"`|
| `config.database.port`         | Database port                                                                                       | `"8123"`                             |
| `clickhouse.enabled`                   | Enable/disable the ClickHouse database deployment                                                   | `true`                               |
| `clickhouse.image.repository`          | ClickHouse Docker image repository                                                                  | `"clickhouse/clickhouse-server"`     |
| `clickhouse.image.tag`                 | ClickHouse Docker image tag                                                                         | `24.2.2`                             |
| `clickhouse.image.pullPolicy`          | ClickHouse image pull policy                                                                        | `"IfNotPresent"`                     |
| `clickhouse.auth.user`                 | ClickHouse username (skip if `clickhouse.secret` set)                                               | `default`                            |
| `clickhouse.auth.password`             | ClickHouse password (skip if `clickhouse.secret` set)                                               | `OPENLIT`                            |
| `clickhouse.service.type`              | Kubernetes Service configuration for ClickHouse                                                     | `LoadBalancer`                       |
| `clickhouse.persistence.accessMode`    | Access mode for the persistent volume                                                               | `ReadWriteOnce`                      |
| `clickhouse.persistence.size`          | Size of the persistent volume                                                                       | `10Gi`                               |
| `ingress.enabled`                      | Toggle to enable/disable ingress for OpenLIT                                                        | `false`                              |
| `ingress.className`                    | Ingress class name                                                                                  | `""`                                 |
| `ingress.hosts[0].host`                | Hostname for the ingress                                                                            | `chart-example.local`                |
| `ingress.hosts[0].paths[0].path`       | Path for the ingress                                                                                | `/`                                  |
| `ingress.hosts[0].paths[0].pathType`   | Type of the ingress path                                                                            | `ImplementationSpecific`             |

**Note**: Although the table above shows the parameters. Refer to [`values.yaml`](values.yaml) for a full list.

### Configuring OpenLIT

You can adjust the OpenLIT configuration by specifying each parameter using the `--set key=value` argument to `helm install`. For example:

```bash
helm install openlit \
  --set service.type=NodePort \
  --set service.port=3000 \
  openlit/openlit
```

Alternatively, you can provide a YAML file that specifies the values for the required parameters while installing the chart. For example:

```bash
helm install openlit -f values.yaml openlit/openlit
```

## Upgrading the Chart

To upgrade the `openlit` deployment:

```bash
helm upgrade openlit openlit/openlit
```

## Uninstalling the Chart

To uninstall/delete the `openlit` deployment:

```bash
helm delete openlit
```

If you've made any changes to [`values.yaml`](values.yaml), remember to use the `-f` flag to provide the updated file.

## Contributing

We welcome contributions to the OpenLIT project. Please refer to [CONTRIBUTING](../../CONTRIBUTING) for detailed guidelines on how you can participate.

## License

OpenLIT is available under the [Apache-2.0 license](../../LICENSE).

## Support

For support, issues, or feature requests, submit an issue through the GitHub issues associated with the OpenLIT Repository and add `Helm` label.
