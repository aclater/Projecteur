# Projecteur

develop: [![Build Status develop](https://travis-ci.org/jahnf/Projecteur.svg?branch=develop)](https://travis-ci.org/jahnf/Projecteur)
master: [![Build Status master](https://travis-ci.org/jahnf/Projecteur.svg?branch=master)](https://travis-ci.org/jahnf/Projecteur)

Linux/X11 application for the Logitech Spotlight device. \
See **[Download](#download)** section for binary packages.

## Motivation

I saw the Logitech Spotlight device in action at a conference and liked it immediately.
Unfortunately as in a lot of cases, software is only provided for Windows and Mac.
The device itself works just fine on Linux, but the cool spotlight feature is
done by additional software.

So here it is: a Linux application for the Logitech Spotlight.

## Table of Contents

  * [Motivation](#motivation)
  * [Features](#features)
  * [Supported Environments](#supported-environments)
  * [How it works](#how-it-works)
  * [Download](#download)
  * [Building](#building)
  * [Installation/Running](#installationrunning)
      * [Pre-requisites](#pre-requisites)
      * [Application Menu](#application-menu)
      * [Command Line Interface](#command-line-interface)
      * [Troubleshooting](#troubleshooting)
  * [License](#license)

## Features

* Configurable desktop spotlight
  * _shade color_, _opacity_, _cursor_, _border_, _center dot_ and different _shapes_.
  * Zoom (magnifier) functionality.
* Multiple screen support

### Screenshots

[<img src="doc/screenshot-settings.png" height="300" />](./doc/screenshot-settings.png)
[<img src="doc/screenshot-spot.png" height="300" />](./doc/screenshot-spot.png)
[<img src="doc/screenshot-traymenu.png">](./doc/screenshot-traymenu.png)

### Planned features

* Support other devices besides the Logitech Spotlight
* Vibration (Timer) Support (Logitech Spotlight)
* Support for device button configuration

## Supported Environments

The application was mostly tested on Ubuntu 18.04 (GNOME) and OpenSuse 15 (GNOME)
but should work on almost any Linux/X11 Desktop. In case you are building the
application youself, make sure you have the correct udev rules installed
(see [pre-requisites section](#pre-requisites)).

## How it works

With a connection via the USB Dongle Receiver or via Bluetooth, the Logitech Spotlight
device will be detected by Linux as a HID device with mouse and keyboard events.
As mouse events the device sends relative cursor movements and left button presses.
Acting as a keyboard, the device basically just sends left and right arrow key press
events when forward or back on the device is pressed.

The mouse events of the detected device is what we are interested in. Since the device is
already detected as a mouse input device and able to move the cursor, we simply detect
if the Spotlight device is sending mouse move events. If it is sending mouse events,
we will 'turn on' the desktop spot.

For more details: Have a look at the source code ;)

## Download

The latest binary packages for some Linux distributions are available for download on bintray.
Currently binary packages for _Ubuntu_, _Debian_, _Fedora_, _OpenSuse_ and
_Arch_ Linux are automatically built.

* Latest develop:
[ ![Download](https://api.bintray.com/packages/jahnf/Projecteur/projecteur-develop/images/download.svg) ](https://bintray.com/jahnf/Projecteur/projecteur-develop/_latestVersion#files)

* Latest release:
[ ![Download](https://api.bintray.com/packages/jahnf/Projecteur/projecteur-master/images/download.svg) ](https://bintray.com/jahnf/Projecteur/projecteur-master/_latestVersion#files)


## Building

### Requirements

* C++14 compiler
* CMake 3.6 or later
* Qt 5.7 and later

### Build Example

Note: You can omit setting the `QTDIR` variable, CMake will then usually find
the Qt version that comes with the distribution's package management.

      > git clone https://github.com/jahnf/projecteur
      > cd projecteur
      > mkdir build && cd build
      > QTDIR=/opt/Qt/5.9.6/gcc_64 
      > cmake ..
      > make

## Installation/Running

### Pre-requisites

#### When building Projecteur yourself

The input devices detected from the Spotlight device must be readable to the
user running the application. To make this easier there is a udev rule template
file in this repository: `55-spotlight.rules.in`

* Copy that file to `/lib/udev/rules.d/55-spotlight.rules`
* Most recent systems (using systemd) will automatically pick up the rule.
  If not, run `sudo udevadm control --reload-rules` and `sudo udevadm trigger`
  to load the rules without a reboot.
* After that the input devices from the Logitech USB Receiver (but also the Bluetooth device)
  in /dev/input should be readable/writeable by you.
  (See also about [device detection](#device-shows-as-not-connected))
* When building against the Qt version that comes with your distribution's packages
  you might need to install some  additional QML module packages. For example this
  is the case for Ubuntu, where you need to install the packages
  `qml-module-qtgraphicaleffrects`, `qml-module-qtquick-window2` and `qml-modules-qtquick2`
  to satisfy the application's runtime dependencies.

### Application Menu

The application menu is accessable via the system tray icon. There you will find
the preferences and the menu entry to exit the application. If the system tray icon is missing,
see the [Troubleshooting](#missing-system-tray) section.

### Command Line Interface

Additional to the standard `--help` and `--version` options, there is an option to send
commands to a running instance of _Projecteur_ and the ability to set properties.

```
Usage: projecteur [option]

<Options>
  -h, --help             Show command line usage.
  --help-all             Show complete command line usage with all properties.
  -v, --version          Print application version.
  --cfg FILE             Set custom config file.
  -d, --device-scan      Print device-scan results.
  -c COMMAND|PROPERTY    Send command/property to a running instance.

<Commands>
  spot=[on|off]          Turn spotlight on/off.
  settings=[show|hide]   Show/hide preferences dialog.
  quit                   Quit the running instance.
```

All the properties that can be set via the command line, are listed with the `--help-all` option.

### Troubleshooting

#### Opaque Spotlight / No Transparency

To be able to show transparent windows a **compositing manager** is necessary. If there is no
compositing manager running you will see the spotlight overlay as an opaque window.

* On **KDE** it might be necessary to turn on Desktop effects to allow transparent windows.
* Depending on your Linux Desktop and configuration there might not be a compositing manager
  running by default. You can run `xcompmgr`, `compton` or others manually.
  * Examples: `xcompmgr -c -t-6 -l-6 -o.1` or `xcompmgr -c`

#### Missing System Tray

_Projecteur_ was developed and tested on GNOME and KDE Desktop environments, but should
work on most other desktop environments. If the system tray with the _Application Menu_
is not showing, commands can be send to the application to bring up the preferences
dialog, to test the spotlight, quit the application or set spotlight properties.
See [Command Line Interface](#command-line-interface).

On some distributions that have a **GNOME Desktop** by default there is **no system tray extensions**
installed (_Fedora_ for example). You can install the "TopIcons Plus" GNOME extension to have
a system tray that can show the Projecteur tray icon (and also from other
applications like Dropbox or Skype)

#### Zoom is not updated while spotlight is shown

That is due to the fact how the zoom currently works. A screenshot is taken shortly before the
overlay window is shown, and then a magnified section is shown wherever the mouse/spotlight is.
If the zoom would be updated while the overlay window is shown, the overlay window it self would
show up in the magnified section. That is a general problem, that also other magnifier tools face,
although they can get around the problem by showing the magnified content rectangle always in the
same position on the screen.

#### Wayland

While not developed with Wayland in mind, users reported _Projecteur_ works with
Wayland. If you experience problems, you can try to set the `QT_QPA_PLATFORM` environment
variable to `wayland`, example:

```
user@ubuntu1904:~/Projecteur/build$ QT_QPA_PLATFORM=wayland ./projecteur
Using Wayland-EGL
```

#### Wayland Zoom

On Wayland the Zoom feature is currently only implemented on KDE and GNOME. This is done with
the help of their respective DBus interfaces for screen capturing. On other environemnts with
Wayland, the zoom feature is currently not supported.

#### Device shows as not connected

If the device shows as not connected, there are some things you can do:

* Check for devices with _Projecteur_'s command line option `-d` or `--device-scan` option.
  This will show you a list of all supported and detected devices and also if
  they are readable/writable. If a detected device is not readable/writable it is an indicator,
  that there is something wrong with the installed _udev_ rules.
* Manually on the shell: Check if the device is detected by the Linux system: Run
  `cat /proc/bus/input/devices | grep -A 5 "Vendor=046d"` \
  This should show one or multiple spotlight devices (among other Logitech devices)
  * Check you the corresponding `/dev/input/event??` device file is readable by you. \
    Example: `test -r /dev/input/event19 && echo "SUCCESS" || echo "NOT readable"`
* Make sure you don't have conflicting udev rules installed, e.g. first you installed
  the udev rule yourself and later you used the automatically built Linux packages to
  install _Projecteur_.

## License

Copyright 2018-2019 Jahn Fuchs

This project is distributed under the [MIT License](https://opensource.org/licenses/MIT), see [LICENSE.md](./LICENSE.md) for more information.
