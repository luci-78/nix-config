{ ... }:

{
  hm.programs.btop = {
    enable = true;
    settings = {
      update_ms = 1000;
      shown_boxes = "proc cpu mem net";
      proc_sorting = "cpu direct";
      show_disks = false;
    };
  };
}
