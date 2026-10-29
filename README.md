# ASUS ROG Zephyrus G14 Gaming & Proton Optimizer (`g14-game-boost`)

A lightweight, zero-overhead hardware management engine and Proton launch wrapper engineered specifically for the **ASUS ROG Zephyrus G14 (GA402RJ)** running modern Linux kernels.

Tailored for the **AMD Ryzen 9 6900HS (Zen 3+)** and **AMD Radeon RX 6700S (Navi 23 dGPU)** architecture.

---

## Live Hardware HUD

```text
  ██████╗  ██╗██╗  ██╗       ██████╗  █████╗ ███╗   ███╗███████╗
 ██╔════╝ ███║██║  ██║      ██╔════╝ ██╔══██╗████╗ ████║██╔════╝
 ██║  ███╗╚██║███████║█████╗██║  ███╗███████║██╔████╔██║█████╗  
 ██║   ██║ ██║╚════██║╚════╝██║   ██║██╔══██║██║╚██╔╝██║██╔══╝  
 ╚██████╔╝ ██║     ██║      ╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗
  ╚═════╝  ╚═╝     ╚═╝       ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝
      ASUS ROG Zephyrus G14 (GA402RJ) Gaming & Proton Optimizer

--- LIVE HARDWARE & ENGINE STATUS ---
  • Platform:       ASUS ROG Zephyrus G14 (GA402RJ)
  • CPU:            AMD Ryzen 9 6900HS (Rembrandt Zen 3+)
  • CPU Clock:      3193 MHz
  • CPU Temp:       87°C
  • dGPU Target:    AMD Radeon RX 6700S [1002:73ef]
  • dGPU Temp:      58°C
  • CPU Governor:   performance
  • Mesa Shaders:   6.0M in ~/.cache/mesa_shader_cache
  • GameMode:       Active (Feral GameMode)
```

---

## Why This Tool Exists

Dual-AMD laptops utilizing SmartAccess Graphics and hybrid switching frequently suffer from subtle performance degradation under Linux:

1. **dGPU Misallocation**: By default, Vulkan and OpenGL renderers may bind to the integrated Radeon 680M iGPU (`1002:1681`) rather than the high-performance Navi 23 RX 6700S dGPU (`1002:73ef`), cutting framerates by more than half.
2. **Unreal Engine 5 & DirectX 12 Shader Stutter**: Heavy titles (like *Silent Hill 2*) suffer from severe pipeline compilation stuttering unless Mesa's Vulkan Graphics Pipeline Library (GPL) is explicitly forced.
3. **Wayland Idle Interruptions**: Playing with a Bluetooth or USB controller often fails to register Wayland/X11 mouse activity, causing screens to dim or sleep mid-gameplay.
4. **Mesa Cache Eviction**: Default 1 GB Mesa shader caches quickly overflow, forcing constant in-game re-compilation.

`g14-game-boost` wraps any game execution to enforce optimal hardware states, zero-stutter shader pipelines, and process-level sleep inhibition.

---

## Technical Scaffolding

When launched with `g14-game-boost run <command>`, the wrapper injects the following optimizations:

| Environment Variable | Target Value | Technical Purpose |
| :--- | :--- | :--- |
| **`DRI_PRIME`** | `1002:73ef!` | Forces OpenGL workloads onto the Radeon RX 6700S dGPU |
| **`MESA_VK_DEVICE_SELECT`** | `1002:73ef!` | Explicitly binds Vulkan instances to the discrete GPU |
| **`RADV_PERFTEST`** | `gpl` | Activates Vulkan Graphics Pipeline Library for asynchronous shader compilation |
| **`MESA_SHADER_CACHE_MAX_SIZE`** | `10G` | Expands Mesa shader cache buffer to 10 GB |
| **`DXVK_ASYNC`** | `1` | Enables asynchronous DXVK pipeline generation |
| **`PROTON_ENABLE_NVAPI`** | `0` | Disables proprietary Nvidia calls on pure AMD RDNA2 silicon |
| **`VKD3D_CONFIG`** | `dxr` | Enables DirectX Raytracing compatibility |

Additionally, execution is wrapped with:
* **`systemd-inhibit`**: Blocks desktop screen dimming and auto-sleep while the game process is active.
* **`gamemoderun`**: Applies Feral Interactive kernel process prioritization (I/O priority, nice values, CPU core affinity).

---

## Quickstart & Installation

Clone and install into your local binary directory:
```bash
git clone https://github.com/patrick-isles/g14-game-boost.git
cd g14-game-boost
./scripts/install.sh
```

---

## Steam Integration

To use `g14-game-boost` automatically across any Steam game (e.g., *Silent Hill 2*):

1. Open **Steam** $\rightarrow$ Right-click your game $\rightarrow$ **Properties...**
2. In the **General** tab under **Launch Options**, paste:
   ```text
   g14-game-boost run %command%
   ```

Now, every time you launch the game through Steam, full dGPU binding, GPL shader caching, and sleep inhibition engage automatically.

---

## CLI Reference

### View Live Hardware HUD:
```bash
g14-game-boost status
```

### Inspect Active Environment Variables:
```bash
g14-game-boost env
```

### Clear Stale Shader Caches:
```bash
g14-game-boost clean-cache
```

### Launch Standalone Wine/Proton Game:
```bash
g14-game-boost run wine game.exe
```

---

## Author
**Patrick Isles**  
*Systems Administration & Linux Kernel Engineering*  
- GitHub: [github.com/patrick-isles](https://github.com/patrick-isles)  
- LinkedIn: [linkedin.com/in/patrick-isles-78aba6232](https://www.linkedin.com/in/patrick-isles-78aba6232/)

---

## License
MIT License. Open-source for the Linux gaming and ROG Zephyrus community.
