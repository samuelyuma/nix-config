# Diagram Patterns

Starting shapes for common flows. Replace the generic names with the real ones from the repo. Quote labels that contain punctuation.

## CI/CD Pipeline (Flowchart)

```mermaid
flowchart LR
    A["Push to main"] --> B["Test"]
    B --> C["Build image"]
    C --> D["Deploy to staging"]
    D --> E{"Manual approval"}
    E -->|approved| F["Deploy to production"]
    E -->|rejected| G["Stop"]
```

## Request Flow (Sequence)

```mermaid
sequenceDiagram
    participant C as Client
    participant H as Handler
    participant S as Service
    participant R as Repository
    C->>H: Request
    H->>S: Validated input
    S->>R: Query
    R-->>S: Rows
    S-->>H: Result
    H-->>C: Response
```

## Lifecycle (State)

```mermaid
stateDiagram-v2
    [*] --> Draft
    Draft --> Review
    Review --> Approved
    Review --> Draft
    Approved --> [*]
```

## Module Relations (Flowchart With Groups)

```mermaid
flowchart TD
    subgraph API
        R["Routes"] --> S["Services"]
    end
    subgraph Data
        S --> D["Repository"]
        D --> P[("Postgres")]
    end
```

## Data Relations (ER)

```mermaid
erDiagram
    USER ||--o{ ORDER : places
    ORDER ||--|{ ORDER_ITEM : contains
```
