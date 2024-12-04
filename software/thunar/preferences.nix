{...}: {
  programs.xfconf.enable = true;

  user.manage.xdg.configFile."xfce4/xfconf/xfce-perchannel-xml/thunar.xml" = {
    force = true;

    text = ''
      <?xml version="1.0" encoding="UTF-8"?>

      <channel name="thunar" version="1.0">
        <property name="last-view" type="string" value="ThunarIconView"/>
        <property name="last-icon-view-zoom-level" type="string" value="THUNAR_ZOOM_LEVEL_300_PERCENT"/>
        <property name="last-window-maximized" type="bool" value="true"/>
        <property name="last-separator-position" type="int" value="172"/>
        <property name="last-details-view-zoom-level" type="string" value="THUNAR_ZOOM_LEVEL_38_PERCENT"/>
        <property name="last-details-view-visible-columns" type="string" value="THUNAR_COLUMN_DATE_MODIFIED,THUNAR_COLUMN_NAME,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_TYPE"/>
        <property name="last-details-view-column-widths" type="string" value="50,50,147,50,50,248,50,50,634,50,50,108,50,158"/>
        <property name="misc-single-click" type="bool" value="false"/>
        <property name="shortcuts-icon-emblems" type="bool" value="false"/>
        <property name="tree-icon-emblems" type="bool" value="false"/>
        <property name="shortcuts-icon-size" type="string" value="THUNAR_ICON_SIZE_16"/>
        <property name="misc-image-preview-mode" type="string" value="THUNAR_IMAGE_PREVIEW_MODE_EMBEDDED"/>
        <property name="last-show-hidden" type="bool" value="false"/>
        <property name="last-toolbar-item-order" type="string" value="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16"/>
        <property name="last-toolbar-visible-buttons" type="string" value="0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"/>
        <property name="misc-thumbnail-mode" type="string" value="THUNAR_THUMBNAIL_MODE_ALWAYS"/>
        <property name="misc-thumbnail-draw-frames" type="bool" value="false"/>
        <property name="misc-text-beside-icons" type="bool" value="false"/>
        <property name="misc-change-window-icon" type="bool" value="false"/>
        <property name="misc-date-style" type="string" value="THUNAR_DATE_STYLE_LONG"/>
        <property name="misc-parallel-copy-mode" type="string" value="THUNAR_PARALLEL_COPY_MODE_NEVER"/>
        <property name="misc-recursive-search" type="string" value="THUNAR_RECURSIVE_SEARCH_NEVER"/>
        <property name="misc-volume-management" type="bool" value="false"/>
        <property name="last-menubar-visible" type="bool" value="true"/>
        <property name="last-sort-column" type="string" value="THUNAR_COLUMN_SIZE"/>
        <property name="last-sort-order" type="string" value="GTK_SORT_ASCENDING"/>
        <property name="last-statusbar-visible" type="bool" value="false"/>
        <property name="last-side-pane" type="string" value="void"/>
        <property name="last-image-preview-visible" type="bool" value="false"/>
        <property name="last-location-bar" type="string" value="void"/>
        <property name="misc-file-size-binary" type="bool" value="false"/>
        <property name="misc-open-new-window-as-tab" type="bool" value="true"/>
      </channel>
    '';
  };
}
