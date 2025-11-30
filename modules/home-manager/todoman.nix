{
  programs.todoman = {
    enable = true;
    glob = "*/*";
    extraConfig = ''
      date_format = "%Y-%m-%d"
      time_format = "%H:%M"
      default_list = "personal"
      default_due = 0
      default_command = "list --sort due"
      humanize = True
    '';
  };
}
