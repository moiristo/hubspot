module HubspotHelper
  
  # Should be included at the bottom of any HTML page (before </body>) you want to track
  def hubspot_javascript_tracker
    raw <<-EOS
      <!-- Start of HubSpot Logging Code -->
      <script type="text/javascript" language="javascript">
      var hs_portalid=#{Hubspot.config.hubspot_portal_id}; 
      var hs_salog_version = "2.00";
      var hs_ppa = "#{Hubspot.config.hubspot_site}";
      document.write(unescape("%3Cscript src='" + document.location.protocol + "//" + hs_ppa + "/salog.js.aspx' type='text/javascript'%3E%3C/script%3E"));
      </script>
      <!-- End of HubSpot Logging Code -->    
    EOS
  end
  
end