# Doku Helm Charts
[![Doku](https://img.shields.io/badge/Doku-orange)](https://github.com/dokulabs/doku)
[![License](https://img.shields.io/github/license/dokulabs/helm?label=license&logo=github&color=f80&logoColor=fff%22%20alt=%22License)](https://github.com/dokulabs/helm/blob/main/LICENSE)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/dokulabs/helm)](https://github.com/dokulabs/helm/pulse)
[![GitHub Contributors](https://img.shields.io/github/contributors/dokulabs/helm)](https://github.com/dokulabs/helm/graphs/contributors)

[![Chart Version](https://img.shields.io/github/tag/dokulabs/helm.svg?&label=Chart%20Version&logo=helm)](https://github.com/dokulabs/helm/tags)
[![Doku Version](https://img.shields.io/github/tag/dokulabs/doku.svg?&label=Doku%20Version&logo=docker)](https://github.com/dokulabs/doku/tags)

[![Helm Test](https://github.com/dokulabs/helm/actions/workflows/helm-test.yml/badge.svg?branch=main)](https://github.com/dokulabs/helm/actions/workflows/helm-test.yml)

## Introduction

Doku is an **open-source LLMOps tool** engineered to enables developers with comprehensive capabilities to monitor, analyze, and optimize LLM applications. It provides valuable real-time data on **LLM usage, performance, and costs**. Through seamless integrations with leading LLM platforms, including OpenAI, Cohere, and Anthropic, Doku acts as a central command center for all your LLM needs. It effectively guides your efforts, ensuring that your LLM applications not only operate at peak efficiency but also scale successfully.

This repository houses the Helm Chart to Deploy Doku and its components along with ClickHouse in a Kubernetes Cluster

## 💿 Installation

To install the Doku chart with the release name `doku`:

```bash
helm repo add dokulabs https://dokulabs.github.io/helm/

helm repo update

helm install doku dokulabs/doku
```

## 🚀 Getting Started post Installation

After the Doku chart is successfully deployed to your Kubernetes cluster, you'll need to generate an API key that can be used by the Dokumetry SDKs to authenticate requests to the Doku platform.

### 🔑 Access Doku UI and Generate an API Key

With Doku running, the next step is to access the Doku UI and generate an API key for secure communication between your applications and Doku.

1. Open your browser and go to Doku UI at `127.0.0.1:3000/login`
2. Login using theb default credentials
    - Email as `user@dokulabs.com`
    - Password as `dokulabsuser`
3. Once you have logged into Doku UI, Go to [API Keys page](http://127.0.0.1:3000/api-keys) and Create an API Key. Copy the generated API Key.

> 💡 **Tip:** Alternatively, you can use the HTTP API to create your Doku API Key. For further details, take a look at the [API Reference](https://docs.dokulabs.com/latest/api-reference/endpoint/api-keys/create) section.

### ⚡️ Instrument your Application with DokuMetry

Select the SDK that matches your application's programming language and integrate LLM monitoring with just a **two lines of code**.

#### Python

Install the `dokumetry` [Python SDK](https://pypi.org/project/dokumetry/) using pip:

```shell
pip install dokumetry
```

Add the following two lines to your application code:

```python
import dokumetry

dokumetry.init(llm=client, doku_url="YOUR_DOKU_INGESTER_URL", api_key="YOUR_DOKU_TOKEN")
```

##### Example Usage for monitoring `OpenAI` Usage:

```python
from openai import OpenAI
import dokumetry

client = OpenAI(
    api_key="YOUR_OPENAI_KEY"
)

# Pass the above `client` object along with your DOKU URL and API key and this will make sure that all OpenAI calls are automatically tracked.
dokumetry.init(llm=client, doku_url="YOUR_DOKU_INGESTER_URL", api_key="YOUR_DOKU_TOKEN")

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

Refer to the `dokumetry` [Python SDK repository](https://github.com/dokulabs/dokumetry-python) for more advanced configurations and use cases.

#### Node

Install the `dokumetry` [NodeJS SDK](https://www.npmjs.com/package/dokumetry) using npm:

```shell
npm install dokumetry
```

Add the following two lines to your application code:

```javascript
import DokuMetry from 'dokumetry';

DokuMetry.init({llm: openai, dokuUrl: "YOUR_DOKU_INGESTER_URL", apiKey: "YOUR_DOKU_TOKEN"})
```

##### Example Usage for monitoring `OpenAI` Usage:

```javascript
import OpenAI from 'openai';
import DokuMetry from 'dokumetry';

const openai = new OpenAI({
  apiKey: 'My API Key', // defaults to process.env["OPENAI_API_KEY"]
});

// Pass the above `openai` object along with your DOKU URL and API key and this will make sure that all OpenAI calls are automatically tracked.
DokuMetry.init({llm: openai, dokuUrl: "YOUR_DOKU_INGESTER_URL", apiKey: "YOUR_DOKU_TOKEN"})

async function main() {
  const chatCompletion = await openai.chat.completions.create({
    messages: [{ role: 'user', content: 'What are the key to effective observability?' }],
    model: 'gpt-3.5-turbo',
  });
}

main();
```

Refer to the `dokumetry` [NodeJS SDK repository](https://github.com/dokulabs/dokumetry-node) for more advanced configurations and use cases.

### Visualize and Analyze

Once you have Doku Ingester and `DokuMetry` SDKs set up, you can instantly get insights into how your LLM applications. Just head over to Doku UI at `127.0.0.1:3000` on your browser to start exploring.

![Doku Client UI](https://github.com/dokulabs/.github/blob/main/profile/assets/doku-client-1.jpg?raw=true)

With Doku, you get a simple, powerful view into important info like how much you’re spending on LLMs, which parts of your app are using them the most, and how well they’re performing. Find out which LLM models are favorites among your applications, and dive deep into performance details to make smart decisions. This setup is perfect for optimizing your app performance and keeping an eye on costs.

## Contributing

We welcome contributions to the Doku project. Please refer to [CONTRIBUTING](CONTRIBUTING) for detailed guidelines on how you can participate.

## License

Doku is available under the [Apache-2.0 license](LICENSE).

## Support

For support, issues, or feature requests, submit an issue through the GitHub issues associated with the Doku Repository and add `Helm` label.
