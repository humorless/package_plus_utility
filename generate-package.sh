#!/usr/bin/env bb
;; This script needs babashka to run
;; https://github.com/borkdude/babashka

;; Design ideas from here
;; https://gist.github.com/humorless/2a2bb80d7675647e54aa79391293ad97


;; config begin

(def base-url "https://www.service-packageplus.com:8088")

(def data {:access_token ""
           :amount 10
           :type "B"
           :size "M"
           :repository "5f434cdcca5d1366ceac30a9"})

;; config end

(defn now []
  (java.time.ZonedDateTime/now))

(defn gen-pkg [base-url data]
  (let [url (str base-url "/eco-package/generate/")
        resp (curl/post url
                        {:headers {"Content-Type" "application/json;charset=UTF-8"
                                   "Accept" "application/json"}
                         :body (json/generate-string data)})
        resp-body (json/parse-string (:body resp))]
    resp-body))


(def out (gen-pkg base-url data))
(println out)
