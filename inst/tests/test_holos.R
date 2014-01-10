context("Testing Holos' metadata functions")

test_that("Metadata is returned as expected", {
	 expect_is(about_ee(type = "data"), "data.frame")
	 expect_true(nrow(about_ee(type = "data")) == 5)
	 expect_true(ncol(about_ee(type = "data")) == 2)
	 expect_is(about_ee(type = "meta-data"), "data.frame")
	 expect_true(nrow(about_ee(type = "meta-data")) == 2)
	 expect_true(ncol(about_ee(type = "meta-data")) == 2)
	 expect_is(about_ee(type = "actions"), "data.frame")
	 expect_true(nrow(about_ee(type = "actions")) == 1)
	 expect_true(ncol(about_ee(type = "actions")) == 2)
	 expect_is(about_ee(type = "data", as.df = FALSE), "list")
	 expect_is(about_ee(type = "meta-data", as.df = FALSE), "list")
	 expect_is(about_ee(type = "actions", as.df = FALSE), "list")
	 expect_is(holos_sources(), "data.frame")
	 expect_true(nrow(holos_sources()) == 10)
	 expect_true(ncol(holos_sources()) == 4)
})


context("Testing photos function")

test_that("Photos function returns results as expected", {
	expect_is(holos_photos(), "holos")
	expect_equal(length(holos_photos()), 4)
	all_cdfa <- holos_photos(collection_code = "CDFA", page = "all")
	expect_equal(nrow(all_cdfa$data), 52)
	some_cdfa <- holos_photos(collection_code = "CDFA", page = 1:2)
	expect_equal(nrow(some_cdfa$data), 20)
	some_other_cdfa <- holos_photos(collection_code = "CDFA", page = c(1:4,6)) 
	expect_equal(nrow(some_other_cdfa$data), 42)
})

context("Testing checklists")

test_that("Checklists work correctly", {
	expect_is(holos_checklists(), "data.frame")
	spiders  <- holos_checklists(subject = "Spiders")
	expect_is(checklist_details(spiders$url[1]), "data.frame")
})


context("Testing sensors")

test_that("Sensor data are returned correctly", {
	expect_is(holos_sensors(), "data.frame")
})

context("Testing observations")

test_that("Observations are correctly retrieved", {
x <- holos_observations(scientific_name_exact = "Pinus")
x1 <- holos_observations(scientific_name_exact = "Pinus", page = 1:5)
expect_error(holos_observations(scientific_name_exact = "Pinus", page = "lol"))
expect_is(x, "holos")
expect_is(x1, "holos")
expect_is(x$data, "data.frame")
})