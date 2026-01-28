{ config, lib, pkgs, inputs, ... }:
{
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
      config = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in {
        modifier = "Mod4";
        input = {
          "*" = {
            xkb_options = "ctrl:nocaps";
          };
        };
        keybindings = lib.mkOptionDefault {
          # Audio Volume Controls (Sink - Output)
          "XF86AudioRaiseVolume" = "exec swayosd-client --output-volume raise";
          "XF86AudioLowerVolume" = "exec swayosd-client --output-volume lower";
          "XF86AudioMute" = "exec swayosd-client --output-volume mute-toggle";
            
          # Brightness Controls
          "XF86MonBrightnessUp" = "exec swayosd-client --brightness raise";
          "XF86MonBrightnessDown" = "exec swayosd-client --brightness lower";
            
          # Media Player Controls
          "XF86AudioPlay" = "exec swayosd-client --playerctl play-pause";
          "XF86AudioNext" = "exec swayosd-client --playerctl next";
          "XF86AudioPrev" = "exec swayosd-client --playerctl prev";

          # TODO: Fix Keyboard Brightness
          "XF86KbdBrightnessUp" = "exec echo not implemented";
          "XF86KbdBrightnessDown" = "exec echo not implemented";

          # Lock
          "${modifier}+l" = "exec swaylock";
        };
      };
    };

    home.packages = with pkgs;
      [
        # Font
        cascadia-code
        wl-clipboard
      ];

    fonts.fontconfig.enable = true;

    programs.swaylock.enable = true;

    services.swayosd = {
      enable = true;
      # May be from 0.0 - 1.0.
      topMargin = 0.9;
      # Custom stylesheet file.
      #stylePath = "/etc/xdg/swayosd/style.css";
    };

    services.swayidle =
    let
      # Lock command
      lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
      # Sway
      display = status: "${pkgs.sway}/bin/swaymsg 'output * power ${status}'";
    in
    {
      enable = true;
      timeouts = [
        {
          timeout = 20;
          command = lock;
        }
        {
          timeout = 25;
          command = display "off";
          resumeCommand = display "on";
        }
        {
          timeout = 30;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
      events = [
        {
          event = "before-sleep";
          command = (display "off") + "; " + lock;
        }
        {
          event = "after-resume";
          command = display "on";
        }
        {
          event = "lock";
          command = (display "off") + "; " + lock;
        }
        {
          event = "unlock";
          command = display "on";
        }
      ];
    };

    programs.firefox.enable = true;
    programs.nixvim = {
      enable = true;
      imports = [ ./programs/nixvim ];
    };
}
