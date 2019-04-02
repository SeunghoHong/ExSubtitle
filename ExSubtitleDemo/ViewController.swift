//
//  ViewController.swift
//  ExSubtitleDemo
//
//  Created by Seungho Hong on 19/02/2019.
//  Copyright © 2019 Seungho Hong. All rights reserved.
//

import UIKit
import AVFoundation

import ExSubtitle

class ViewController: UIViewController {

    var asset: AVAsset!
    var player: AVPlayer!
    var playerItem: AVPlayerItem!
    var playerLayer: AVPlayerLayer!
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    var exSubtitle: ExSubtitle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.includesApproximationPhrase = true
        formatter.includesTimeRemainingPhrase = true
        formatter.allowedUnits = [.hour, .minute, .second]
    }

    @IBAction func touchUpSMI(_ sender: Any) {
    }
    
    @IBAction func touchUpSRT(_ sender: Any) {
        self.parse(data: """
1
00:00:13,800 --> 00:00:16,150
No, that's not how it is.

2
00:00:16,150 --> 00:00:17,380
I didn't mean that.

3
00:00:17,380 --> 00:00:20,350
But seriously, I think your boobs got bigger.

4
00:00:19,630 --> 00:00:20,350
Die.

5
00:00:20,350 --> 00:00:22,850
Eww, you pervert! But—

6
00:00:20,870 --> 00:00:22,830
Letterbox: Yadomi Atsushi, Touko, Jinta

7
00:00:21,410 --> 00:00:22,220
Die!

8
00:00:22,830 --> 00:00:24,620
Die, die, die, die!

9
00:00:24,620 --> 00:00:26,400
Die, die, die, die!

10
00:00:26,400 --> 00:00:30,220
Stop passing on your inferior genes, you horny animals!
""".data(using: .utf8), mimetype: .smi)
    }

    @IBAction func touchUpASS(_ sender: Any) {
    }

    @IBAction func touchUpVTT(_ sender: Any) {
    }

    @IBAction func touchUpTTML(_ sender: Any) {
        #if true
        self.parse(data: """
<?xml version="1.0" encoding="UTF-8"?>
<tt xmlns="http://www.w3.org/ns/ttml">
  <head>
    <metadata xmlns:ttm="http://www.w3.org/ns/ttml#metadata">
      <ttm:title>Timed Text TTML Example</ttm:title>
      <ttm:copyright>The Authors (c) 2006</ttm:copyright>
    </metadata>
    <styling xmlns:tts="http://www.w3.org/ns/ttml#styling">
      <style xml:id="s1" tts:color="white" tts:fontFamily="proportionalSansSerif" tts:fontSize="22px" tts:textAlign="center" />
      <style xml:id="s2" style="s1" tts:color="yellow"/>
      <style xml:id="s1Right" style="s1" tts:textAlign="end" />
      <style xml:id="s2Left" style="s2" tts:textAlign="start" />
    </styling>
    <layout xmlns:tts="http://www.w3.org/ns/ttml#styling">
      <region xml:id="subtitleArea" style="s1" tts:extent="560px 62px" tts:padding="5px 3px" tts:backgroundColor="black" tts:displayAlign="after" />
<region xml:id="r1" style="s2">
  <style tts:extent="306px 114px"/>
  <style tts:backgroundColor="red"/>
  <style tts:backgroundOrigin="padding"/>
  <style tts:padding="27px 72px"/>
  <style tts:backgroundRepeat="noRepeat"/>
  <style tts:backgroundImage="#blue102px57px"/>
  <style tts:backgroundClip="content"/>
</region>
    </layout>
  </head>
  <body region="subtitleArea">
    <div>
      <p xml:id="subtitle1" begin="0.76s" end="3.45s">
        It seems a paradox, does it not,
      </p>
      <p xml:id="subtitle2" begin="5.0s" end="10.0s">
        that the image formed on<br/>
        the Retina should be inverted?
      </p>
      <p xml:id="subtitle3" begin="10.0s" end="16.0s" region="r1" style="s2">
        It is puzzling, why is it<br/>
        we do not see things upside-down?
      </p>
      <p xml:id="subtitle4" begin="17.2s" end="23.0s">
        You have never heard the Theory,<br/>
        then, that the Brain also is inverted?
      </p>
      <p xml:id="subtitle5" begin="25.0s" end="27.0s" style="s2">
        No indeed! What a beautiful fact!
      </p>
    </div>
  </body>
</tt>
""".data(using: .utf8), mimetype: .ttml)
        #endif
    }
}

extension ViewController {

    func stop() {
        if self.player != nil {
            self.player.pause()
            self.player = nil
            self.playerItem = nil
            self.playerLayer.removeFromSuperlayer()
            self.playerLayer = nil
            self.exSubtitle = nil
        }
    }

    func start() {
        self.stop()

        if let url = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8") {
            self.asset = AVAsset(url: url)
            self.playerItem = AVPlayerItem(asset: self.asset)
            self.player = AVPlayer(playerItem: self.playerItem)
            self.playerLayer = AVPlayerLayer(player: self.player)
            
            self.videoView.layer.addSublayer(self.playerLayer)
            self.playerLayer.frame = self.videoView.frame
            
            self.exSubtitle = ExSubtitle(player: self.player)
            
            self.player.play()
        }
    }
    
    func onCue(_ cue: Cue) {
        DispatchQueue.main.async {
            let payloads = cue.payloads.map {
"""
region
\($0.styles?.region?.toString() ?? "")
style
\($0.styles?.style?.toString() ?? "")
text
\($0.text)
"""
            }.joined(separator: "\n")
            self.textView.text = "count: \(cue.payloads.count)\n" + payloads
            print("\(self.textView.text ?? "")")
        }
    }

    func parse(data: Data?, mimetype: ExSubtitle.MimeType) {
        guard let data = data else { return }

        self.start()
        self.exSubtitle.parse(from: data, mimetype: mimetype, completionHandler: { print("success") }, errorHandler: onError(_:))
        self.exSubtitle.setOnCue(self.onCue(_:))
    }
}

extension ViewController {

    func onError(_ error: Error?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Calcel", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

