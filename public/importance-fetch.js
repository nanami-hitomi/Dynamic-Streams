importanceFetch = function () {
    axios.get("/importance")
        .then((res) => {
            //remove importance from everything
            for (var tag of document.getElementsByTagName("video")) {
                tag.classList.remove("important")
            }
            //important the things in the axios query
            for(var id of res.data){
                if(id!="")
                    document.getElementById(id).classList.add("important")
            }
        })
        .catch((err)=>{
            console.error(err)
        })
}

//do it the first time, then setup to do it every 500ms or so
importanceFetch()

setInterval(importanceFetch,500)