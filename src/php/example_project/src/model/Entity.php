<?php

namespace Model;

class Entity
{
    private $id;
    /**
     * @param mixed $id
     */
    public function setId($id)
    {
        $this->id = $id;
    }

    public function id()
    {
        return $this->id;
    }
}
