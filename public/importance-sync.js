importanceFetch = function () {
    axios.get("/importance")
        .then((res) => {
            //remove importance from everything
            for (var tag of document.getElementsByClassName("name")) {
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

importanceSend = function (name){
    axios.post('/importance',{name:name})
    importanceFetch()
}

importanceFetch()
//keep synced with server in case there are changes
setInterval(importanceFetch,500)