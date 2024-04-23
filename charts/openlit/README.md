# OpenLIT Helm Chart - LLM Monitoring
[![OpenLIT](https://img.shields.io/badge/OpenLIT-orange)](https://github.com/openlit/openlit)
[![License](https://img.shields.io/github/license/openlit/helm?label=license&logo=github&color=f80&logoColor=fff%22%20alt=%22License)](https://github.com/openlit/helm/blob/main/LICENSE)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/openlit/helm)](https://github.com/openlit/helm/pulse)
[![GitHub Contributors](https://img.shields.io/github/contributors/openlit/helm)](https://github.com/openlit/helm/graphs/contributors)

[![Chart Version](https://img.shields.io/github/tag/openlit/helm.svg?&label=Chart%20Version&logo=helm)](https://github.com/openlit/helm/tags)
[![openlit Version](https://img.shields.io/github/tag/openlit/openlit.svg?&label=openlit%20Version&logo=docker)](https://github.com/openlit/openlit/tags)

[![Helm Test](https://github.com/openlit/helm/actions/workflows/helm-test.yml/badge.svg?branch=main)](https://github.com/openlit/helm/actions/workflows/helm-test.yml)

## Introduction

OpenLIT is an **open-source LLMOps tool** engineered to enables developers with comprehensive capabilities to monitor, analyze, and optimize LLM applications. It provides valuable real-time data on **LLM usage, performance, and costs**. Through seamless integrations with leading LLM platforms, including OpenAI, Cohere, and Anthropic, OpenLIT acts as a central command center for all your LLM needs. It effectively guides your efforts, ensuring that your LLM applications not only operate at peak efficiency but also scale successfully.

Deploy OpenLIT effortlessly with our Helm Chart in your Kubernetes cluster and start mastering your LLM operations today!

## 💿 Installation

To install the OpenLIT chart with the release name `openlit`:

```bash
helm repo add openlit https://openlit.github.io/helm/

helm repo update

helm install openlit openlit/openlit
```

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

**Note**: Although the table above shows the parameters. Refer to [`values.yaml`](values.yaml) for a full list.

### Configuring OpenLIT

You can adjust the OpenLIT configuration by specifying each parameter using the `--set key=value` argument to `helm install`. For example:

```bash
helm install openlit \
  --set openlit.service.type=NodePort \
  --set openlit.service.port=3000 \
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
