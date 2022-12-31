require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ) ]
    )
    allow(WeatherstackApi).to receive(:get_weather_in).with("kumpula").and_return({"request"=>{"type"=>"City", "query"=>"Turku, Finland", "language"=>"en", "unit"=>"m"}, "location"=>{"name"=>"Turku", "country"=>"Finland", "region"=>"Western Finland", "lat"=>"60.450", "lon"=>"22.283", "timezone_id"=>"Europe/Helsinki", "localtime"=>"2022-12-31 12:33", "localtime_epoch"=>1672489980, "utc_offset"=>"2.0"}, "current"=>{"observation_time"=>"10:33 AM", "temperature"=>5, "weather_code"=>122, "weather_icons"=>["https://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0004_black_low_cloud.png"], "weather_descriptions"=>["Overcast"], "wind_speed"=>22, "wind_degree"=>210, "wind_dir"=>"SSW", "pressure"=>992, "precip"=>0.9, "humidity"=>93, "cloudcover"=>100, "feelslike"=>0, "uv_index"=>1, "visibility"=>10, "is_day"=>"yes"}})


    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if more than one are returned by the API, they are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ), Place.new( name: "Janoinen lohi", id: 2 ) ]
    )

    allow(WeatherstackApi).to receive(:get_weather_in).with("kumpula").and_return({"request"=>{"type"=>"City", "query"=>"Turku, Finland", "language"=>"en", "unit"=>"m"}, "location"=>{"name"=>"Turku", "country"=>"Finland", "region"=>"Western Finland", "lat"=>"60.450", "lon"=>"22.283", "timezone_id"=>"Europe/Helsinki", "localtime"=>"2022-12-31 12:33", "localtime_epoch"=>1672489980, "utc_offset"=>"2.0"}, "current"=>{"observation_time"=>"10:33 AM", "temperature"=>5, "weather_code"=>122, "weather_icons"=>["https://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0004_black_low_cloud.png"], "weather_descriptions"=>["Overcast"], "wind_speed"=>22, "wind_degree"=>210, "wind_dir"=>"SSW", "pressure"=>992, "precip"=>0.9, "humidity"=>93, "cloudcover"=>100, "feelslike"=>0, "uv_index"=>1, "visibility"=>10, "is_day"=>"yes"}})

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Janoinen lohi"
  end

  it "if no places returned by the API, show notification at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      []
    )
    allow(WeatherstackApi).to receive(:get_weather_in).with("kumpula").and_return({"request"=>{"type"=>"City", "query"=>"Turku, Finland", "language"=>"en", "unit"=>"m"}, "location"=>{"name"=>"Turku", "country"=>"Finland", "region"=>"Western Finland", "lat"=>"60.450", "lon"=>"22.283", "timezone_id"=>"Europe/Helsinki", "localtime"=>"2022-12-31 12:33", "localtime_epoch"=>1672489980, "utc_offset"=>"2.0"}, "current"=>{"observation_time"=>"10:33 AM", "temperature"=>5, "weather_code"=>122, "weather_icons"=>["https://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0004_black_low_cloud.png"], "weather_descriptions"=>["Overcast"], "wind_speed"=>22, "wind_degree"=>210, "wind_dir"=>"SSW", "pressure"=>992, "precip"=>0.9, "humidity"=>93, "cloudcover"=>100, "feelslike"=>0, "uv_index"=>1, "visibility"=>10, "is_day"=>"yes"}})


    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
  end
end