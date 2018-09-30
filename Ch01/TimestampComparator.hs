{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}
import Database.MongoDB
import Data.Time.Clock.POSIX
import Data.Aeson
import Control.Applicative
import qualified Data.ByteString.Lazy as B

main :: IO ()
main = do
  let db = "socialhub"
  pipe <- connect (host "172.17.0.3")
  e <- access pipe master db run
  close pipe

  print e

  curTime <- fmap round getPOSIXTime
  print curTime

run = do
  getData

getData = rest =<< find (select [] "priority_queue_tripadvisor") {sort=[ "ts" =: 1]}
