import express from "express";

const router = express.Router();

router.get('/', (_req,res)=>{
    res.send('Fetching all entry diaries')

})


router.post('/', (_req,res)=>{
    res.send('saving a dary')
    
})


export default router;