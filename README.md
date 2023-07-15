# Godot-4-2D-destroy-effect ![Godot v4.0](https://img.shields.io/badge/Godot-v4.1-%23478cbf) ![GitHub](https://img.shields.io/github/license/Jummit/godot-destruction-plugin)

Basic script that takes sprite divided into frames and perform destroy effect/simulate explosion.

## Parameters

### Collide

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `collide` | `bool` | Flag indicating if fragments will have acive collision shape | `true` |

### Force

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `force` | `float` | Force that will be applied to each fragment | `50` |

### Timeout

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `timeout` | `float` | Time after which fragments will disappear | `5` |

### gravity

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `gravity` | `float` | Gravity of the fragments | `1` |

### Scale modifier

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `scale_modifier` | `float` | If not 0 then scale of fragments will constantly be changing during falling | `0` |

### Width Limit

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `width_limit` | `float` | Indicates how far wide will the fragments go | `5` |

### Height Limit

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `height_limit` | `float` | Indicates how far high will the fragments go | `2` |
