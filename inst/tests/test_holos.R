context("Testing Holos' metadata functions")

test_that("Metadata is returned as expected", {
	 expect_is(about_bee(type = "data"), "data.frame")
	 expect_true(nrow(about_bee(type = "data")) == 5)
	 expect_true(ncol(about_bee(type = "data")) == 2)
	 expect_is(about_bee(type = "meta-data"), "data.frame")
	 expect_true(nrow(about_bee(type = "meta-data")) == 2)
	 expect_true(ncol(about_bee(type = "meta-data")) == 2)
	 expect_is(about_bee(type = "actions"), "data.frame")
	 expect_true(nrow(about_bee(type = "actions")) == 1)
	 expect_true(ncol(about_bee(type = "actions")) == 2)
	 expect_is(about_bee(type = "data", as.df = FALSE), "list")
	 expect_is(about_bee(type = "meta-data", as.df = FALSE), "list")
	 expect_is(about_bee(type = "actions", as.df = FALSE), "list")
	 expect_is(holos_sources(), "data.frame")
	 expect_true(nrow(holos_sources()) == 10)
	 expect_true(ncol(holos_sources()) == 4)
})


context("Testing photos function")

test_that("Photos function returns results as expected", {
	expect_is(holos_photos(), "holos")
	expect_equal(length(holos_photos()), 4)
	some_cdfa <- holos_photos_get(collection_code = "CDFA", page = 1:2)
	expect_equal(nrow(some_cdfa$data), 20)
})