# AGP (AerotechGroundPro) Roadmap

This document outlines the development roadmap for AGP (AerotechGroundPro), the advanced Ground Control Station for UAVs. It covers both completed features and future plans, providing a transparent overview of the project's direction.

## Completed Features

This section highlights the key features that are already implemented in AGP.

### Core Functionality
- **MAVLink Support**: Full support for all MAVLink-enabled drones.
- **Open Source**: Fully open-source, allowing for community contributions and custom modifications.
- **Vehicle Setup**: Specialized setup and configuration for PX4 and ArduPilot powered vehicles.
- **MAVLink 2 Signing**: Enhanced security with MAVLink 2 message signing.
- **Log Replay**: Functionality to replay flight logs for analysis.
- **MAVLink Forwarding**: Ability to forward MAVLink traffic to a specified UDP port.

### Flight Control
- **Comprehensive Control**: Full flight control and in-flight mission management capabilities.
- **MAVLink Actions**: Execute custom commands and actions on the vehicle.
- **VTOL Support**: Advanced support for Vertical Take-Off and Landing (VTOL) vehicles, including transition-distance settings.
- **Region of Interest (ROI)**: Dynamically point the vehicle's camera at a specific point of interest.
- **ADSB Integration**: Support for ADSB receivers for displaying traffic from other aircraft.

### Mission Planning
- **Intuitive Interface**: Easy-to-use drag-and-drop interface for creating complex missions.
- **3D Verification**: Export missions to KML for 3D visualization and verification.
- **Terrain Following**: Plan missions with terrain-following capabilities, including a terrain profile view with collision indications.
- **GeoFence and Rally Points**: Support for defining GeoFences and Rally Points (ArduPilot).
- **Pattern Tools**: Advanced tools for creating survey grids, corridors, and structure scans.

### User Interface
- **Rebranding**: Complete rebranding from QGroundControl to the new AGP identity.
- **Modern UI**: A beginner-friendly and intuitive user interface.
- **Combined Instruments**: An enhanced navigation instrument that combines the compass and attitude indicator.
- **Dynamic Battery Display**: Configurable battery bars to monitor power levels effectively.
- **MAVLink Inspector**: A tool for inspecting and analyzing MAVLink messages.

### Video and Camera
- **Video Streaming**: Support for real-time video streaming with a low-latency mode.
- **Camera Control**: Control for simple cameras, including photo and video capture.
- **Image Capture**: Ability to capture still images from the video stream.

## Roadmap

This section outlines the planned features and improvements for future releases of AGP. The roadmap is subject to change based on community feedback and technological advancements.

### Short-Term Goals (Next 1-3 Months)
- **Enhanced UI/UX**: Further refinements to the user interface for an even more intuitive experience.
- **Improved Documentation**: Expand the official documentation with more tutorials and examples.
- **Performance Optimization**: Focus on improving the performance and stability of the application.

### Mid-Term Goals (Next 3-6 Months)
- **Advanced Mission Planning**: Introduce new mission planning tools, such as the ability to create missions from imported 3D models.
- **Smarter Vehicle Setup**: Streamline the vehicle setup process with more automated checks and configurations.
- **Expanded Telemetry**: Add support for more advanced telemetry data and custom dashboards.

### Long-Term Goals (Next 6-12 Months)
- **AI Integration**: Explore the integration of AI-powered features, such as autonomous obstacle avoidance and intelligent mission planning.
- **Cloud Integration**: Develop cloud-based services for storing and sharing flight data, mission plans, and logs.
- **Multi-Vehicle Control**: Enhance the capabilities for controlling and monitoring multiple vehicles simultaneously.

**Note**: This roadmap is a living document and will be updated regularly to reflect the project's progress and priorities. We welcome feedback and contributions from the community to help shape the future of AGP.
