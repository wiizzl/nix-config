{ ... }:

{
  stylix.targets.swaync.enable = false;

  services.swaync = {
    enable = true;

    settings = {
      positionX = "right";
      positionY = "top";
      control-center-positionX = "none";
      control-center-positionY = "none";
      control-center-margin-top = 8;
      control-center-margin-bottom = 8;
      control-center-margin-right = 8;
      control-center-margin-left = 8;
      control-center-width = 500;
      control-center-height = -1;
      fit-to-screen = false;
      layer-shell-cover-screen = true;

      layer-shell = true;
      layer = "overlay";
      control-center-layer = "overlay";
      cssPriority = "user";
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      notification-inline-replies = true;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      notification-window-width = 500;
      keyboard-shortcuts = true;
      image-visibility = "always";
      transition-time = 200;
      hide-on-clear = true;
      hide-on-action = true;
      script-fail-notify = true;

      widgets = [
        "inhibitors"
        "dnd"
        "mpris"
        "notifications"
      ];
      widget-config = {
        notifications = {
          vexpand = false;
        };
        inhibitors = {
          text = "Inhibitors";
          button-text = "Clear All";
          clear-all-button = true;
        };
        title = {
          text = "Notifications";
          clear-all-button = false;
          button-text = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        label = {
          max-lines = 5;
          text = "Label Text";
        };
        mpris = {
          autohide = true;
        };
      };
    };

    style = ''
      :root {
        --border-radius: 22px;
        --cc-bg: transparent;

        --widget-background: rgba(46, 46, 46, 0.7);
        --noti-bg-alpha: 0.6;

        --padding: calc(var(--border-radius) / 2);
      }

      .control-center {
        border-radius: 0;
      }

      .widgets > .widget,
      .widget-mpris > carouselindicatordots,
      .widget-mpris > box > button {
        background: var(--widget-background);
        border-radius: var(--border-radius);
        padding: calc(var(--border-radius) / 2);
        border: var(--border);
      }

      .control-center-list-placeholder {
        padding: var(--border-radius);
      }

      .notification-group {
        border-radius: var(--border-radius);
        padding: 8px;
      }

      .widget.widget-mpris {
        background: transparent;
        border-radius: 0;
        padding: 0;
        border: none;
      }
      .widget.widget-mpris > carouselindicatordots {
        --dots-padding: 4px;
        padding: var(--dots-padding);
        padding-left: var(--dots-padding);
        padding-right: calc(6px + var(--dots-padding));
        margin: 0;
        margin-top: var(--padding);
      }
      .widget-mpris > box > button:hover {
        background: rgba(46, 46, 46, 1);
      }
      .widget-mpris-player {
        box-shadow: none;
        border: var(--border);
        margin: 0 var(--padding);
      }
      .widget-mpris-player:only-child {
        margin: 0;
      }
    '';
  };
}
