module ReleasePackagesHelper
  
  
    $PACKAGING_STATUS = [ :MAKING , :PENDING, :READY_FOR_USE]
    $GAME_SUPPORT_PLAFORMS = [:XBox360, :PC, :PS3 ]
    $DEFAULT_PACKAGES_SAVE_LOCATIONS = [ "//spicydata/BuildStore" ]
    $RELEASE_TYPES = [ :daily_build, :weekly_build, :ea_release, :milestone, :demo_show]
end
