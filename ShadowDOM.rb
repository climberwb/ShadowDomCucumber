def shadow_click(shadow_elm, target, index)
  execute_script("
    var shadow_elm = '#{shadow_elm}';
    var target = '#{target}';
    var index = '#{index}';

    window.qa.tap(document.querySelectorAll( shadow_elm+ ' /deep/ ' +target)[index]);
  ")
end
