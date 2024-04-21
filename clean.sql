INSERT INTO scrub_dump
(SELECT
	(raw_json->'routes'->0->'legs'->0->'summary'->'departureTime')::TEXT::TIMESTAMPTZ,
  CASE
  	WHEN (raw_json->'routes'->0->'legs'->0->'summary'->'lengthInMeters')::INT > 81000
    AND (raw_json->'routes'->0->'legs'->0->'summary'->'lengthInMeters')::INT < 83000 THEN 'Portland'
    WHEN (raw_json->'routes'->0->'legs'->0->'summary'->'lengthInMeters')::INT > 77000
    AND (raw_json->'routes'->0->'legs'->0->'summary'->'lengthInMeters')::INT < 79000 THEN 'Salem'
 		ELSE 'Undetermined'
  END,
  (raw_json->'routes'->0->'legs'->0->'summary'->'lengthInMeters')::INT,
  (raw_json->'routes'->0->'legs'->0->'summary'->'noTrafficTravelTimeInSeconds')::INT,
  (raw_json->'routes'->0->'legs'->0->'summary'->'travelTimeInSeconds')::INT,
  (raw_json->'routes'->0->'legs'->0->'summary'->'trafficDelayInSeconds')::INT
FROM road_scraper);

DELETE FROM road_scraper;