context("Testing Ecoengine metadata functions")

test_that("Metadata is returned as expected", {
	 expect_is(ee_about(type = "data"), "data.frame")
	 expect_true(nrow(ee_about(type = "data")) == 5)
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
	 expect_is(ee_sources(), "data.frame")
	 expect_true(nrow(ee_sources()) == 10)
	 expect_true(ncol(ee_sources()) == 4)
})


context("Testing photos function")

test_that("Photos function returns results as expected", {
	expect_is(ee_photos(), "ecoengine")
	expect_equal(length(ee_photos()), 4)
	all_cdfa <- ee_photos(collection_code = "CDFA", page = "all")
	expect_equal(nrow(all_cdfa$data), 52)
	some_cdfa <- ee_photos(collection_code = "CDFA", page = 1:2)
	expect_equal(nrow(some_cdfa$data), 20)
	some_other_cdfa <- ee_photos(collection_code = "CDFA", page = c(1:4,6)) 
	expect_equal(nrow(some_other_cdfa$data), 42)
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
x <- ee_observations(scientific_name_exact = "Pinus")
x1 <- ee_observations(scientific_name_exact = "Pinus", page = 1:5)
expect_error(ee_observations(scientific_name_exact = "Pinus", page = "lol"))
expect_is(x, "ecoengine")
expect_is(x1, "ecoengine")
expect_is(x$data, "data.frame")
})

context("Testing search")
test_that("Elastic search works correctly", {
	x <- ee_search(query = "genus:Lynx")
	expect_is(x, "list")
})