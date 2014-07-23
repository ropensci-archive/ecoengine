context("Testing Ecoengine metadata functions")

test_that("Metadata is returned as expected", {
	 expect_is(ee_about(type = "data"), "data.frame")
	 expect_true(nrow(ee_about(type = "data")) == 4)
	 expect_true(ncol(ee_about(type = "data")) == 2)
	 expect_is(ee_about(type = "meta-data"), "data.frame")
	 expect_true(nrow(ee_about(type = "meta-data")) == 2)
	 expect_true(ncol(ee_about(type = "meta-data")) == 2)
	 expect_is(ee_about(type = "actions"), "data.frame")
	 expect_true(nrow(ee_about(type = "actions")) == 1)
	 expect_true(ncol(ee_about(type = "actions")) == 2)
	 expect_is(ee_about(type = "data", as.df = FALSE), "list")
	 expect_is(ee_about(type = "meta-data", as.df = FALSE), "list")
	 expect_is(ee_about(type = "actions", as.df = FALSE), "list")
	 # expect_is(ee_sources(), "data.frame")
	 # expect_true(nrow(ee_sources()) == 10)
	 # expect_true(ncol(ee_sources()) == 4)
	 # expect_is(ee_footprints(), "data.frame")
	 aves1 <- ee_observations(clss = "aves", county = "Alameda county", georeferenced = TRUE)
	 aves2 <- ee_observations(clss = "aves",  georeferenced = TRUE)
	 expect_more_than(aves2$results, aves1$results)

})


context("Testing photos function")

test_that("Photos function returns results as expected", {
	expect_is(ee_photos(), "ecoengine")
	expect_equal(length(ee_photos()), 4)
	all_cdfa <- ee_photos(collection_code = "CDFA", page = "all")
	expect_equal(nrow(all_cdfa$data), 54)
	some_cdfa <- ee_photos(collection_code = "CDFA", page_size = 10)
	expect_more_than(nrow(all_cdfa$data), nrow(some_cdfa$data))
})

context("Testing checklists")

test_that("Checklists work correctly", {
	expect_is(ee_checklists(), "data.frame")
	spiders  <- ee_checklists(subject = "Spiders")
	expect_is(checklist_details(spiders$url[1]), "data.frame")
})


context("Testing sensors")

test_that("Sensor data are returned correctly", {
	expect_is(ee_sensors(), "data.frame")
})

context("Testing observations")

test_that("Observations are correctly retrieved", {
x <- ee_observations(genus__exact = "Pinus")
x_geo <- ee_observations(genus__exact = "Pinus", georeferenced = TRUE)
x1 <- ee_observations(genus__exact = "Pinus", page = 1:2)
expect_error(ee_observations(genus__exact = "Pinus", page = "lol"))
expect_is(x, "ecoengine")
expect_is(x1, "ecoengine")
expect_is(x$data, "data.frame")
difference <- x$results - x_geo$results
expect_true(difference > 0)
})

context("Testing search")
test_that("Elastic search works correctly", {
	x <- ee_search(query = "genus:Lynx")
	expect_is(x, "data.frame")
	all_lynx_data <- ee_search_obs(query  = "Lynx")
	expect_is(all_lynx_data$data, "data.frame")
	expect_is(all_lynx_data, "ecoengine")
})


context("Testing sensor data")

test_that("Sensor data is returned correctly", {
full_sensor_list <- ee_sensors()
expect_is(full_sensor_list, "data.frame")
x <- full_sensor_list[1, ]$record
sensor_data <- ee_sensor_data(sensor_id = x, page = 1:2)
expect_is(sensor_data, "ecoengine")
expect_is(sensor_data$data, "data.frame")
})

context("Testing sensor intervals")

test_that("Sensors work correctly", {
test <- ee_sensor_agg(sensor_id = 1625, weeks = 2)
test1 <- ee_sensor_agg(sensor_id = 1625, month = 1)
test2 <- ee_sensor_agg(sensor_id = 1629, hours = 2, minutes = 3, seconds = 4)
expect_is(test$data, "data.frame")
expect_is(test1$data, "data.frame")
expect_is(test2$data, "data.frame")
expect_equal(ncol(test$data), 6)
expect_equal(ncol(test1$data), 6)
expect_equal(ncol(test2$data), 6)
sensor_df <- ee_sensor_agg(page = "all", sensor_id = 1625, weeks = 2)
expect_is(sensor_df$data, "data.frame")
})

context("eebind works correctly")

test_that("We can combine multiple calls into one", {
	x1 <- ee_observations(genus = "Lynx", page = 1)
	x2 <- ee_observations(genus = "Lynx", page = 2)
	x12 <- ee_cbind(list(x1, x2))
	expect_is(x12, "ecoengine")
	expect_is(x12$data, "data.frame")
	x3 <- ee_observations(genus = "Helianthus", page = 2)
	expect_error(ee_cbind(list(x1, x2, x3)))

})
