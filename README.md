# DetectFacialAbnormalities

## Overview

The DetectFacialAbnormalities app is an iOS application designed to detect facial abnormalities such as pimples, acne, and dark circles in images. It leverages CoreData for persistent storage and a vision service for image analysis. The app follows the MVVM architecture, ensuring modularity, testability, and maintainability.

## Features

- *Face Detection*: Detects faces in images and analyzes for abnormalities.
- *Image Storage*: Stores images and their analysis results using CoreData.
- *Camera and Gallery Integration*: Allows users to capture images using the camera or select images from the photo library.

## Architecture

The app is structured using the MVVM (Model-View-ViewModel) pattern:

- *Model*: Manages the application's data layer using CoreData.
- *View*: Consists of the FaceCaptureViewController which handles user interactions.
- *ViewModel*: The ImageProcessingViewModel handles the logic for processing images and interacting with the CoreData layer.

## Setup

### Prerequisites

- Xcode 12.0 or later
- iOS 13.0 or later

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/SaketTokoPedia/FaceAnamolyDetection.git
