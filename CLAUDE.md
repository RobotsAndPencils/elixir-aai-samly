# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Samly is an Elixir SAML 2.0 Service Provider library for Phoenix/Plug applications. It enables Single Sign-On (SSO) authentication using SAML and supports multiple Identity Providers (IdPs) including Okta, Ping Identity, OneLogin, ADFS, and others.

## Development Commands

### Building and Testing
- `mix compile` - Compile the project
- `mix test` - Run the test suite
- `mix format` - Format code according to Elixir standards
- `mix docs` - Generate documentation
- `mix deps.get` - Install dependencies
- `mix deps.update` - Update dependencies

### Interactive Development
- `iex -S mix` - Start IEx with the project loaded

## Architecture Overview

### Core Components

The library follows a structured approach with these key modules:

- **Samly.Provider** (`lib/samly/provider.ex`) - GenServer that manages SP configuration and loads IdP metadata. Must be added to the application supervision tree.
- **Samly.Router** (`lib/samly/router.ex`) - Main routing entry point that forwards to specialized routers:
  - `/auth` → Samly.AuthRouter (sign-in/sign-out)
  - `/sp` → Samly.SPRouter (metadata, consume, logout endpoints)
  - `/csp-report` → Samly.CsprRouter (CSP violation reports)
- **Samly.Assertion** (`lib/samly/assertion.ex`) - Represents SAML assertions with user attributes
- **Samly** (`lib/samly.ex`) - Main API module providing `get_active_assertion/1` and `get_attribute/2`

### State Management

The library supports two state store backends:
- **Samly.State.ETS** - ETS-based storage (default, single-node)
- **Samly.State.Session** - Plug session-based storage (recommended for clusters)

### IdP ID Resolution

Two modes for identifying Identity Providers:
- **Path Segment** (default): `/sso/auth/signin/idp_name`
- **Subdomain**: `idp_name.domain.com/sso/auth/signin`

### Security Features

Built-in security measures include:
- Request/response signing with SHA256
- Certificate verification
- CSP headers with nonces
- RelayState validation
- Protection against replay attacks
- Encrypted assertion support

## Configuration Structure

Configuration is done via `config/config.exs` with three main sections:

1. **Service Providers** - Your application's SP configuration (certificates, entity ID)
2. **Identity Providers** - IdP configurations (metadata files, signing preferences)
3. **State Store** - Backend storage configuration

## Integration Points

- Router integration requires a `/sso` scope forwarding to `Samly.Router`
- Applications access user data via `Samly.get_active_assertion(conn)`
- Custom attribute processing via `pre_session_create_pipeline` plug pipeline
- Session management through configured state store

## Key Dependencies

- `esaml` - Core SAML processing (Erlang library)
- `plug` - Web application interface
- `sweet_xml` - XML processing utilities

## Common Development Patterns

When working with this codebase:
- Configuration changes require understanding SP/IdP relationships
- New features often involve router modifications and corresponding handlers
- State management changes should consider both ETS and Session backends
- Security-related changes must maintain signing and validation integrity