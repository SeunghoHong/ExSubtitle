---
title: ExSubtitle
date: 
version: 0.0.1
---

# ExSubtitle

## Overview

`ExSubtitle` provides interface for external subtitle that is not supported by `AVPlayer`.

* parses an external subtitle with source
* notifies a timed text and additional information based on the playback position of `AVPlayer`

## Supported format

* TTML (application/xml+ttml, application/ttml+xml)
* WebVTT (text/vtt)
* SRT (application/x-subrip)
* SMI (application/smil+xml)
* ASS (application/x-ass)


## Interface definition

### ExSubtitle

#### Constants

##### Mimetype

Constants that describe types of subtitle.

``` swift
enum MimeType {
    case smi, srt, ass, vtt, ttml
}
```

Name    | Description
------- | ---------------------------------
ttml    | TimedTextMarkupLanguage
vtt     | WebVTT
srt     | SubRip
smi     | SAMI
ass     | SubStationAlpha

#### Methods

##### init(player:)

Applicaton should create the `ExSubtitle` instance with an `AVPlayer`.

*Declaration:*

``` swift
init(player: AVPlayer)
```

*Parameters:*

Name    | Description
------- | ---------------------------------
player  | AVPlayer

*Example:*

``` swift
var asset = AVAsset(url: url)
var playerItem = AVPlayerItem(asset: asset)
var player = AVPlayer(playerItem: playerItem)

var exSubtitle = ExSubtitle(player: player)
```

#### parse(from:mimetype:)

Applicaton should get the subtitle data and mimtype from the file or url resource.

*Declaration:*

``` swift
func parse(from data: Data, mimetype: MimeType)
```

*Parameters:*

Name    | Description
------- | ---------------------------------
onCue	| No description.

> // TODO: error handling

*Example:*

``` swift
self.exSubtitle.parse(from: data, mimetype: .ttml)
```

#### setOnCue(_:)

`ExSubtitle` notities the timed text and information as `Cue` class via `onCue` listener.

*Declaration:*

``` swift
func setOnCue(_ onCue: @escaping ((Cue) -> Void))
```

*Parameters:*

Name    | Description
------- | ---------------------------------
onCue	| No description.

*Example:*

``` swift
self.exSubtitle.setOnCue {
    $0.payloads.forEach {
        print("\($0.text)")
    }
}
```

### Cue

#### Properties

##### start

*Declaration*

``` swift
var start: CMTime
```

##### end

*Declaration*

``` swift
var end: CMTime
```

##### payloads

*Declaration*

``` swift
typealias Styles = (region: Style?, style: Style?)
typealias Payload = (text: String, setting: String?, styles: Styles?)

var payloads: [Payload]
```

