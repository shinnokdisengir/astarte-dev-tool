# AstarteDevTool

```mermaid
---
title: State diagram
---
stateDiagram-v2
  direction TB
  %% Definitions
  state ConfigCheck <<choice>>
  state UpCheck <<choice>>
  classDef interrupt font-weight:bold,fill:white
  %% Links
  [*] --> ConfigCheck

  ConfigCheck --> Break
  ConfigCheck --> Config: Not configured yet
  ConfigCheck --> UpCheck: Already configured
  
  UpCheck --> Break
  UpCheck --> Idle: Env down
  UpCheck --> Up: Env up

  Config --> Break
  Config --> Idle
  
  Idle --> Up
  Idle --> Break
  Idle --> [*]
  
  Up --> Realm
  Up --> [*]
  Up --> Break
  note right of Up
      Astarte dev mode up & ready
  end note

  Realm --> Interface
  Realm --> Device
  Realm --> Break
  Realm --> [*]

  Break:::interrupt --> [*]
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `astarte_dev_tool` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:astarte_dev_tool, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/astarte_dev_tool>.

