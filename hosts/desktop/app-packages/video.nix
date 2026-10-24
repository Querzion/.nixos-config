{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
  mpv
  vlc
  vlc-bittorrent
  ffmpeg
  mediainfo

  (wrapOBS {
    plugins = with obs-studio-plugins; [
      obs-multi-rtmp
      #obs-source-switcher
      advanced-scene-switcher
      obs-pipewire-audio-capture
      wlrobs
      obs-tuna
      obs-vkcapture
      input-overlay
      waveform
      obs-vaapi
      droidcam-obs
      obs-vertical-canvas
    ];
  })

  gst_all_1.gstreamer
  gst_all_1.gst-plugins-base
  gst_all_1.gst-plugins-good
  gst_all_1.gst-plugins-bad
  gst_all_1.gst-plugins-ugly
  gst_all_1.gst-libav

  ];
}
