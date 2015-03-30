context("Testing Ecoengine metadata functions")

test_that("Metadata is returned as expected", {
   skip_on_cran()
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
	 expect_is(ee_sources(), "data.frame")
	 expect_true(ncol(ee_sources()) == 6)
	# expect_is(ee_footprints(), "data.frame")
	 aves1 <- ee_observations(clss = "aves", county = "Alameda county", georeferenced = TRUE)
	 aves2 <- ee_observations(clss = "aves",  georeferenced = TRUE)
	 expect_more_than(aves2$results, aves1$results)

})


context("Testing photos function")

test_that("Photos function returns results as expected", {
  skip_on_cran()
	photos_df <- ee_photos()
  expect_is(photos_df, "ecoengine")
	expect_equal(length(photos_df), 4)
	all_cdfa <- ee_photos(collection_code = "CDFA", page = "all")
	expect_equal(nrow(all_cdfa$data), 54)
	some_cdfa <- ee_photos(collection_code = "CDFA", page_size = 10)
	expect_more_than(nrow(all_cdfa$data), nrow(some_cdfa$data))
})



context("Testing observations")

test_that("Observations are correctly retrieved", {
  skip_on_cran()
  x <- ee_observations(genus__exact = "Pinus")
  x_geo <- ee_observations(genus__exact = "Pinus", georeferenced = TRUE)
  x1 <- ee_observations(genus__exact = "Pinus", page = 1:2)
  expect_error(ee_observations(genus__exact = "Pinus", page = "lol"))
  expect_is(x, "ecoengine")
  expect_is(x1, "ecoengine")
  expect_is(x$data, "data.frame")
  difference <- x$results - x_geo$results
  expect_true(difference > 0)
  aves <- ee_observations(clss = "aves", extra = "kingdom,genus")
  expect_match(sort(unique(aves$data$genus))[1], "aechmophorus")
  expect_error(ee_observations(scientific_name = "linepithema humile", page_size = 1))
})


context("eebind works correctly")

test_that("We can combine multiple calls into one", {
  skip_on_cran()
	x1 <- ee_observations(genus = "Lynx", page = 1, page_size = 50)
	x2 <- ee_observations(genus = "Lynx", page = 2, page_size = 50)
	x12 <- ee_cbind(list(x1, x2))
	expect_is(x12, "ecoengine")
	expect_is(x12$data, "data.frame")
	x3 <- ee_observations(genus = "Helianthus", page = 2, page_size = 100)
	expect_error(ee_cbind(list(x1, x2, x3)))

})

context("Testing checklists")

test_that("Checklists work correctly", {
  skip_on_cran()
	expect_is(ee_checklists(), "data.frame")
	spiders  <- ee_checklists(subject = "Spiders")
	expect_is(checklist_details(spiders$url[1]), "data.frame")
})



context("Testing search")
test_that("Elastic search works correctly", {
  skip_on_cran()
	x <- ee_search(query = "genus:Lynx")
	expect_is(x, "data.frame")
	all_lynx_data <- ee_search_obs(query  = "Lynx")
	expect_is(all_lynx_data$data, "data.frame")
	expect_is(all_lynx_data, "ecoengine")
})




