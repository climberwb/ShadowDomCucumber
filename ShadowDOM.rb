d# Drop in methods for interacting with shadowDOM elements in capybara
module Shadow
  extend Capybara::DSL

  def self.click(shadow_elm, target, index=0)
    execute_script("
      var shadow_elm = '#{shadow_elm}';
      var target = '#{target}';
      var index = '#{index}';

      window.qa.tap(document.querySelectorAll( shadow_elm+ ' /deep/ ' +target)[index]);
    ")
  end

  def self.present?(shadow_elm, target, index=0)
    execute_script("
      var shadow_elm = '#{shadow_elm}';
      var target = '#{target}';
      var index = '#{index}';

      return (document.querySelectorAll( shadow_elm+ ' /deep/ ' +target)[index] != null);
    ")
  end

  def self.icon_attr_present?(shadow_elm, target, index=0,attribute)
    execute_script("
      var shadow_elm = '#{shadow_elm}';
      var target = '#{target}';
      var index = '#{index}';
      var attribute = '#{attribute}';

      return (document.querySelectorAll( shadow_elm+ ' /deep/ ' +target)[index].icon == attribute);
    ")
  end


  def self.text_present?(shadow_elm, target, text, index=0)
    execute_script("
      var shadow_elm = '#{shadow_elm}';
      var target = '#{target}';
      var index = '#{index}';
      var text = '#{text}';
      var shadow_elm_object = document.querySelectorAll( shadow_elm+ ' /deep/ ' + target)[index];
      var detected_text = shadow_elm_object.textContent.trim() || shadow_elm_object.innerText.trim();

      return detected_text.search(text) >= 0;
    ")
  end

  def self.ajax_click_and_request?(shadow_elm, target, url, index=0)
    page.execute_script("
      var shadow_elm = '#{shadow_elm}';
      var target = '#{target}';
      var index = '#{index}';
      var url = '#{url}';

      window.qa.ajax.clear();
      document.querySelectorAll( shadow_elm+ ' /deep/ ' + target)[index].dispatchEvent( new CustomEvent( 'tap', { bubbles: true } ) );
    ")
    sleep 1
    page.execute_script("
      return window.qa.ajax.wasRequested(url);
    ")
  end

  def self.ajax_request?(url)
    page.execute_script("
      var url = '#{url}';

      window.qa.ajax.clear();
    ")
    sleep 1
    page.execute_script("
      return window.qa.ajax.wasRequested(url);
    ")
  end


#new shadow function to get values
  def self.get_value(shadow_elm, target, index=0)
    execute_script("
      var shadow_elm = '#{shadow_elm}';
      var target = '#{target}';
      var index = '#{index}';
      var text = '#{text}';
      var shadow_elm_object = document.querySelectorAll( shadow_elm+ ' /deep/ ' + target)[index];
      var detected_text = shadow_elm_object.textContent.trim() || shadow_elm_object.innerText.trim();

      return detected_text;
    ")
  end
end
