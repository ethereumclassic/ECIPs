# Add OpenRPC Service Discovery

    ECLIP: 2
    Title: Add OpenRPC Service Discovery
    Author: Shane Jonas, Zachary Belford
    Status: WIP
    Type: Interface
    Created: 2019-02-25

# Abstract
### What is this?

This is a proposal to add [OpenRPC](https://github.com/open-rpc/spec) support by adding the method [`rpc.discover`](https://github.com/open-rpc/spec#service-discovery-method) to the projects [JSON-RPC](https://www.jsonrpc.org/specification) API to enable automation and tooling.

# Motivation
### What is the problem?

- Maintenence time and accuracy on:
    - documentation
    - APIs
    - clients
- Not all JSON-RPC servers return the same methods or return the same version of the API.
- There is nothing that provides both human *and* machine-readable interfaces to be able to interact with JSON-RPC. 
- Communication between services in different programming languages is not easy.
- Implementation usually comes at the cost of user experience consuming the API.

# Implementation
### How do I Solve the problem?
JSON-RPC APIs can support the OpenRPC specification by implementing a service discovery method that will return the [OpenRPC document](https://github.com/open-rpc/spec#openrpc-document) for the JSON-RPC API. The method MUST be named `rpc.discover`. The `rpc.` prefix is a reserved method prefix for [JSON-RPC 2.0 Specification](https://www.jsonrpc.org/specification) system extensions.

# Specification

### What is OpenRPC?
The [OpenRPC](https://github.com/open-rpc/spec) Specification defines a standard, programming language-agnostic interface description for [JSON-RPC 2.0](https://www.jsonrpc.org/specification) APIs, which allows both humans and computers to discover and understand the capabilities of a service without requiring access to source code, additional documentation, or inspection of network traffic. When properly defined via OpenRPC, a consumer can understand and interact with the remote service with a minimal amount of implementation logic. Similar to what interface descriptions have done for lower-level programming, the OpenRPC Specification removes guesswork in calling a service.

# Rationale
### Why would we do this?
Services need to figure out how to talk to each other. If we really want to build the next generation automation then having up to date libraries, documented APIs, and modern tool are going to provide easy discovery, on-boarding and interaction.

Use cases for machine-readable [JSON-RPC 2.0](https://www.jsonrpc.org/specification) API definition documents include, but are not limited to:

- A common vocabulary and document will keep developers, testers, architects, and technical writers all in sync.
- Server stubs/skeletons generated in many languages
- Clients generated in many languages 
- Mock Server generated in many languages 
- Tests generated many language tests
- Documentation Generation

# Alternative
Since [OpenRPC](https://github.com/open-rpc/spec) documents just describe a [JSON-RPC](https://www.jsonrpc.org/specification) APIs services and are represented in JSON format. These documents may either be produced and served statically or be generated dynamically from an application and returned via the [`rpc.discover`](https://github.com/open-rpc/spec#service-discovery-method) method. This gives projects and communities the flexibility to adopt tools before the [`rpc.discover`](https://github.com/open-rpc/spec#service-discovery-method) is implemented.
