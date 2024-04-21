INSERT INTO scrub_dump
(SELECT
	(raw_json->'routes'->0->'legs'->0->'summary'->'departureTime')::TEXT::TIMESTAMPTZ AS departure_time,
  CASE
  	WHEN (raw_json->'routes'->0->'legs'->0->'summary'->'lengthInMeters')::INT > 81000
    AND (raw_json->'routes'->0->'legs'->0->'summary'->'lengthInMeters')::INT < 83000 THEN 'Portland'
    WHEN (raw_json->'routes'->0->'legs'->0->'summary'->'lengthInMeters')::INT > 77000
    AND (raw_json->'routes'->0->'legs'->0->'summary'->'lengthInMeters')::INT < 79000 THEN 'Salem'
 		ELSE 'Undetermined'
  END origin,
  (raw_json->'routes'->0->'legs'->0->'summary'->'lengthInMeters')::INT AS distance,
  (raw_json->'routes'->0->'legs'->0->'summary'->'noTrafficTravelTimeInSeconds')::INT AS perfect_time,
  (raw_json->'routes'->0->'legs'->0->'summary'->'travelTimeInSeconds')::INT AS travel_time,
  (raw_json->'routes'->0->'legs'->0->'summary'->'trafficDelayInSeconds')::INT AS traffic_delay
FROM road_scraper);

DELETE FROM road_scraper;