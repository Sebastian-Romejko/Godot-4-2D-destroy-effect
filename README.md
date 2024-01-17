# Godot-4-2D-destroy-effect ![Godot v4.0](https://img.shields.io/badge/Godot-v4.1-%23478cbf) ![GitHub](https://img.shields.io/github/license/Jummit/godot-destruction-plugin)

Basic script that takes sprite divided into frames and perform destroy effect/simulate explosion.

## Usage

* create `Sprite2D` as new scene and split it into frames in `Animation` section (e.g. name: `fragment`)
* create `Node2D` and attach this script to it (e.g. name: `destructible_object`)
* change `FRAGMENT_PATH` inside script to target this `Sprite2D` scene created before
* instantiate `destructible_object` scene, destroy effect is on `SPACE` by default

## Limitations

Object for destruction has to be sprite that is divided into frames. Size of fragments depends of how frames would be divided.

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

## Credits

Thanks to

* Airvikar - for this [Youtube video](https://www.youtube.com/watch?v=ExX7Qyldtfg) that is the code base for this script.
* [Hiulit](https://github.com/hiulit) - for inspiration to do my own script for Godot 4 (and also inspiration for README structure :P), [similar explosion for Godot 3](https://github.com/hiulit/Godot-3-2D-Destructible-Objects)
  
## License

[MIT License](LICENSE).
